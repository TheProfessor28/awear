import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/serial/serial_packet.dart';
import 'connection_provider.dart';

part 'device_discovery_provider.g.dart';

enum DeviceType { receiver, sender, unknown }

// 1. MUTABLE CLASS (The "Single Instance" Fix)
class ConnectedDevice {
  final String portName;
  DeviceType type;
  String macAddress;
  final SerialPort port;
  final SerialPortReader reader;
  StreamSubscription? subscription;
  String? pairedToMac;

  ConnectedDevice({
    required this.portName,
    required this.type,
    this.macAddress = "Unknown",
    required this.port,
    required this.reader,
    this.subscription,
    this.pairedToMac,
  });
}

@riverpod
class PairingStatus extends _$PairingStatus {
  @override
  String? build() => null;
  void setSuccess() {
    state = "Success";
    Future.delayed(const Duration(seconds: 3), () => state = null);
  }
}

@Riverpod(keepAlive: true)
class DeviceManager extends _$DeviceManager {
  Timer? _scanTimer;
  final List<ConnectedDevice> _activeDevices = [];

  // STATE
  Set<String> _lastKnownPorts = {};
  final Set<String> _ignoredPorts = {};

  // BUFFER & METRICS
  String _serialBuffer = "";
  int _packetsReceived = 0;

  @override
  Future<List<ConnectedDevice>> build() async {
    // print("CORE: Device Manager Started (Async Init)");

    // Allow the Splash Screen to render
    await Future.delayed(const Duration(milliseconds: 3000));

    // 1. Load Blacklist
    await _loadBlacklist();

    // 2. Perform Initial Scan & Wait for it
    await _checkForPortChanges(notify: false);

    // 3. Start Periodic Timer for future checks
    _startScanning();

    ref.onDispose(() {
      _scanTimer?.cancel();
      _closeAll();
    });

    // 4. Return initial list
    return [..._activeDevices];
  }

  // --- PUBLIC HELPERS ---
  // FIXED: Access state.value because state is now AsyncValue
  ConnectedDevice? get receiver =>
      state.value?.where((d) => d.type == DeviceType.receiver).firstOrNull;

  ConnectedDevice? get sender =>
      state.value?.where((d) => d.type == DeviceType.sender).firstOrNull;

  // --- BLACKLIST LOGIC ---

  Future<void> _loadBlacklist() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? saved = prefs.getStringList('ignored_serial_ports');
    if (saved != null) {
      _ignoredPorts.addAll(saved);
    }
  }

  Future<void> _handlePortFailure(
    String portName, {
    bool permanent = false,
  }) async {
    _ignoredPorts.add(portName);
    if (permanent) {
      // print("CORE: Permanently blacklisting $portName.");
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList('ignored_serial_ports') ?? [];
      if (!saved.contains(portName)) {
        saved.add(portName);
        await prefs.setStringList('ignored_serial_ports', saved);
      }
    }
  }

  // --- SCANNING LOGIC ---

  void _closeAll() {
    for (final dev in _activeDevices) {
      _forceDisconnect(dev);
    }
  }

  // Helper getters need to handle AsyncValue now
  ConnectedDevice? get currentReceiver =>
      state.value?.where((d) => d.type == DeviceType.receiver).firstOrNull;
  ConnectedDevice? get currentSender =>
      state.value?.where((d) => d.type == DeviceType.sender).firstOrNull;

  void _startScanning() {
    _scanTimer = Timer.periodic(const Duration(seconds: 2), (_) async {
      await _checkForPortChanges(notify: true);
    });
  }

  Future<void> _checkForPortChanges({bool notify = true}) async {
    final currentPortsList = SerialPort.availablePorts;
    final currentPorts = currentPortsList.toSet();

    final addedPorts = currentPorts.difference(_lastKnownPorts);
    final removedPorts = _lastKnownPorts.difference(currentPorts);

    _lastKnownPorts = currentPorts;

    // Handle Unplug
    if (removedPorts.isNotEmpty) {
      for (final portName in removedPorts) {
        final activeDev = _activeDevices
            .where((d) => d.portName == portName)
            .firstOrNull;
        if (activeDev != null) {
          await _forceDisconnect(activeDev);
        }
        _ignoredPorts.remove(portName);
      }
      if (notify) _updateState();
    }

    // Handle Plug In
    if (addedPorts.isNotEmpty) {
      for (final portName in addedPorts) {
        if (['COM1', 'COM2'].contains(portName)) {
          _handlePortFailure(portName, permanent: true);
          continue;
        }
        if (_ignoredPorts.contains(portName)) continue;

        // print("CORE: New port detected: $portName. Connecting...");

        // Note: We don't await the full handshake here to avoid blocking UI for too long,
        // but we initiate the connection.
        _connectAndIdentify(portName);
      }
      // Note: We don't update state immediately here because _connectAndIdentify
      // is async and will update state when it succeeds/fails.
    }
  }

  Future<void> _connectAndIdentify(String portName) async {
    final port = SerialPort(portName);

    // 1. Attempt Open
    try {
      if (!port.openReadWrite()) {
        _handlePortFailure(portName, permanent: false);
        return;
      }
    } catch (e) {
      _handlePortFailure(portName, permanent: false);
      return;
    }

    try {
      final config = SerialPortConfig();
      config.baudRate = 921600;
      config.dtr = 1;
      config.rts = 1;
      config.bits = 8;
      config.stopBits = 1;
      config.parity = SerialPortParity.none;

      // 2. Attempt Config (Catch Error 87)
      try {
        port.config = config;
      } catch (e) {
        port.close();
        // This is a hardware mismatch -> Permanent Blacklist
        _handlePortFailure(portName, permanent: true);
        return;
      }

      port.flush();

      // 3. Create Connection
      final reader = SerialPortReader(port, timeout: 0);

      final device = ConnectedDevice(
        portName: portName,
        type: DeviceType.unknown,
        port: port,
        reader: reader,
        subscription: null,
      );

      _activeDevices.add(device);
      _updateState(); // Notify that we have a (tentative) device

      // 4. Listen
      device.subscription = reader.stream.listen(
        (data) {
          final str = String.fromCharCodes(data);
          _handleRawData(device, str);
        },
        onError: (err) {
          if (!err.toString().contains("errno = 0")) {
            // print("CORE: Error on $portName: $err");
          }
          _forceDisconnect(device);
        },
        onDone: () => _forceDisconnect(device),
      );

      // 5. Handshake
      try {
        port.write(Uint8List.fromList("AWEAR_IDENTIFY\n".codeUnits));
      } catch (e) {
        _forceDisconnect(device);
        return;
      }

      // 6. Timeout Check
      Future.delayed(const Duration(seconds: 4), () {
        if (_activeDevices.contains(device) &&
            device.type == DeviceType.unknown) {
          // print("CORE: $portName did not identify. Closing.");
          _forceDisconnect(device);
          // Temporary blacklist (maybe it's just a different device)
          _handlePortFailure(portName, permanent: false);
        }
      });
    } catch (e) {
      try {
        port.close();
      } catch (_) {}
      _handlePortFailure(portName, permanent: false);
    }
  }

  void _handleRawData(ConnectedDevice device, String chunk) {
    // 1. IDENTITY CHECK
    if (device.type == DeviceType.unknown) {
      if (chunk.contains("AWEAR_RECEIVER")) {
        // print("CORE: SUCCESS! Recognized RECEIVER on ${device.portName}");
        device.type = DeviceType.receiver;
        _updateState();
      } else if (chunk.contains("AWEAR_SENDER")) {
        // print("CORE: SUCCESS! Recognized SENDER on ${device.portName}");
        device.type = DeviceType.sender;
        _updateState();
      } else if (chunk.contains('"sender":') && chunk.contains('"rssi":')) {
        // print("CORE: Implicitly recognized RECEIVER on ${device.portName}");
        device.type = DeviceType.receiver;
        _updateState();
      }
    }

    // 2. ROUTING
    if (device.type == DeviceType.receiver) {
      _parseLines(chunk);
    } else if (device.type == DeviceType.sender) {
      if (chunk.contains("PAIRED_OK")) {
        ref.read(pairingStatusProvider.notifier).setSuccess();
      }
    }
  }

  Future<void> _forceDisconnect(ConnectedDevice dev) async {
    _activeDevices.remove(dev);
    _updateState();
    try {
      await dev.subscription?.cancel();
      dev.reader.close();
      if (dev.port.isOpen) dev.port.close();
    } catch (e) {
      // Ignore cleanup errors. The device might already be disconnected or the port closed.
    }
  }

  void _updateState() {
    state = AsyncValue.data([..._activeDevices]);
  }

  void _parseLines(String chunk) {
    _serialBuffer += chunk;
    if (_serialBuffer.length > 50000) _serialBuffer = "";

    while (_serialBuffer.contains('\n')) {
      final index = _serialBuffer.indexOf('\n');
      final line = _serialBuffer.substring(0, index).trim();
      _serialBuffer = _serialBuffer.substring(index + 1);

      if (line.isNotEmpty) {
        _attemptJsonParse(line);
      }
    }
  }

  void _attemptJsonParse(String jsonString) {
    try {
      final json = jsonDecode(jsonString);
      if (json.containsKey('device')) return;

      final packet = SerialPacket.fromJson(json);

      ref.read(packetStreamProvider.notifier).emit(packet);

      _packetsReceived++;
      // if (_packetsReceived % 50 == 0) {
      //   print(
      //     "CORE STATUS: $_packetsReceived packets. HR: ${packet.heartRate} | RSSI: ${packet.rssi}",
      //   );
      // }
    } catch (e) {
      // Ignore malformed JSON packets.
      // This happens frequently with serial data streams.
    }
  }

  Future<void> pairSender(String receiverMac) async {
    final senderDev = state.value
        ?.where((d) => d.type == DeviceType.sender)
        .firstOrNull;
    if (senderDev != null) {
      final cmd = "PAIR:$receiverMac\n";
      senderDev.port.write(Uint8List.fromList(cmd.codeUnits));
    }
  }
}
