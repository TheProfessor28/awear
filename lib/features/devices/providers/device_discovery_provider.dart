import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/serial/serial_packet.dart';
import 'connection_provider.dart';

part 'device_discovery_provider.g.dart';

enum DeviceType { receiver, sender, unknown }

class ConnectedDevice {
  final String portName;
  final DeviceType type;
  final String macAddress;
  final SerialPort port;
  final StreamSubscription? subscription;
  // NEW: Store who this device is paired to (mainly for Sender)
  final String? pairedToMac;

  ConnectedDevice({
    required this.portName,
    required this.type,
    required this.macAddress,
    required this.port,
    this.subscription,
    this.pairedToMac,
  });
}

// Temporary object to pass data from Probe -> Register
class ProbeResult {
  final String portName;
  final SerialPort port;
  final DeviceType type;
  final String mac;
  final String? pairedTo; // NEW

  ProbeResult(this.portName, this.port, this.type, this.mac, {this.pairedTo});
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
  final Set<String> _checkedPorts = {};

  @override
  List<ConnectedDevice> build() {
    print("CORE: Device Manager Started");
    _startScanning();
    ref.onDispose(() {
      _scanTimer?.cancel();
      _closeAll();
    });
    return [];
  }

  void _closeAll() {
    for (final dev in _activeDevices) {
      dev.subscription?.cancel();
      dev.port.close();
    }
  }

  ConnectedDevice? get receiver =>
      state.where((d) => d.type == DeviceType.receiver).firstOrNull;
  ConnectedDevice? get sender =>
      state.where((d) => d.type == DeviceType.sender).firstOrNull;

  void _startScanning() {
    _scanTimer = Timer.periodic(const Duration(seconds: 2), (_) async {
      await _scanForNewPorts();
    });
  }

  Future<void> _scanForNewPorts() async {
    final available = SerialPort.availablePorts.toSet();

    // 1. CLEANUP
    final toRemove = <ConnectedDevice>[];
    for (final device in _activeDevices) {
      if (!available.contains(device.portName)) {
        toRemove.add(device);
      }
    }

    if (toRemove.isNotEmpty) {
      for (final dev in toRemove) {
        print("CORE: Device removed: ${dev.portName}");
        await _forceDisconnect(dev);
      }
      _updateState();
    }

    // 2. DISCOVERY
    _checkedPorts.removeWhere((p) => !available.contains(p));
    final activeNames = _activeDevices.map((d) => d.portName).toSet();
    final candidates = available
        .where((p) => !activeNames.contains(p) && !_checkedPorts.contains(p))
        .toList();

    if (candidates.isEmpty) return;

    print("CORE: Probing candidates: $candidates");

    // 3. PARALLEL PROBING
    final futures = candidates.map((portName) async {
      _checkedPorts.add(portName);
      return await _probePort(portName);
    });

    final probeResults = await Future.wait(futures);

    bool added = false;
    for (final result in probeResults) {
      if (result != null) {
        print(
          "CORE: Success! Connected to ${result.type} on ${result.portName}",
        );
        final dev = _registerDevice(result);
        _activeDevices.add(dev);
        added = true;
      }
    }

    if (added) {
      _updateState();
    }
  }

  Future<ProbeResult?> _probePort(String portName) async {
    final port = SerialPort(portName);
    if (!port.openReadWrite()) return null;

    final config = SerialPortConfig();
    ProbeResult? result;
    String buffer = "";

    try {
      config.baudRate = 115200;
      // Kickstart
      config.dtr = 0;
      config.rts = 0;
      port.config = config;
      await Future.delayed(const Duration(milliseconds: 100));

      config.dtr = 1;
      config.rts = 1;
      port.config = config;

      // Wait for Boot
      await Future.delayed(const Duration(milliseconds: 2000));

      port.flush();

      final reader = SerialPortReader(port, timeout: 2000);
      port.write(Uint8List.fromList("AWEAR_IDENTIFY\n".codeUnits));

      await for (final data in reader.stream) {
        final chunk = String.fromCharCodes(data);
        buffer += chunk;

        // print("CORE DEBUG $portName: $chunk"); // What saying?

        if (buffer.contains("{") && buffer.contains("}")) {
          final start = buffer.indexOf("{");
          final end = buffer.lastIndexOf("}");
          if (end > start) {
            final jsonStr = buffer.substring(start, end + 1);
            try {
              final json = jsonDecode(jsonStr);

              if (json['device'] == 'AWEAR_RECEIVER') {
                result = ProbeResult(
                  portName,
                  port,
                  DeviceType.receiver,
                  json['mac'],
                );
                break;
              } else if (json['device'] == 'AWEAR_SENDER') {
                // NEW: Capture 'paired_to' from JSON
                final pairedTo = json['paired_to'];
                result = ProbeResult(
                  portName,
                  port,
                  DeviceType.sender,
                  json['mac'],
                  pairedTo: pairedTo,
                );
                break;
              }
            } catch (_) {}
          }
        }
      }
    } catch (e) {
      // Timeout
    } finally {
      config.dispose();
    }

    if (result == null) {
      port.close();
      return null;
    }
    return result;
  }

  // ConnectedDevice _registerDevice(ProbeResult info) {
  //   final reader = SerialPortReader(info.port);
  //   final sub = reader.stream.listen(
  //     (data) {
  //       final str = String.fromCharCodes(data);
  //       _handleData(info.type, str);
  //     },
  //     onError: (err) {
  //       print("CORE: Error on ${info.portName}: $err");
  //       _handleStreamError(info.portName);
  //     },
  //     onDone: () {
  //       _handleStreamError(info.portName);
  //     },
  //   );

  //   return ConnectedDevice(
  //     portName: info.portName,
  //     type: info.type,
  //     macAddress: info.mac,
  //     port: info.port,
  //     subscription: sub,
  //     pairedToMac: info.pairedTo, // NEW: Pass it to the final object
  //   );
  // }

  ConnectedDevice _registerDevice(ProbeResult info) {
    //  Start Listening
    final reader = SerialPortReader(info.port);
    final sub = reader.stream.listen(
      (data) {
        // DEBUG: Confirm we are receiving bytes
        // print("STREAM ${info.portName}: ${data.length} bytes");

        final str = String.fromCharCodes(data);
        _handleData(info.type, str);
      },
      onError: (err) {
        print("CORE: Error on ${info.portName}: $err");
        _handleStreamError(info.portName);
      },
      onDone: () {
        _handleStreamError(info.portName);
      },
    );

    return ConnectedDevice(
      portName: info.portName,
      type: info.type,
      macAddress: info.mac,
      port: info.port,
      subscription: sub,
      pairedToMac: info.pairedTo,
    );
  }

  void _handleStreamError(String portName) {
    final dev = _activeDevices.where((d) => d.portName == portName).firstOrNull;
    if (dev != null) {
      _forceDisconnect(dev).then((_) {
        _activeDevices.remove(dev);
        _updateState();
      });
    }
  }

  Future<void> _forceDisconnect(ConnectedDevice dev) async {
    try {
      await dev.subscription?.cancel();
      dev.port.close();
    } catch (e) {}
  }

  void _updateState() {
    state = [..._activeDevices];
  }

  void _handleData(DeviceType type, String data) {
    // For Receiver, we expect JSON lines
    if (type == DeviceType.receiver) {
      _parseAndEmit(data);
    }
    // For Sender (Direct USB), we expect PAIR confirmation
    else if (type == DeviceType.sender) {
      if (data.contains("PAIRED_OK")) {
        ref.read(pairingStatusProvider.notifier).setSuccess();
      }
    }
  }

  // void _parseAndEmit(String chunk) {
  //   final lines = const LineSplitter().convert(chunk);
  //   for (final line in lines) {
  //     try {
  //       if (line.contains('"sender":')) {
  //         final json = jsonDecode(line);
  //         final packet = SerialPacket.fromJson(json);
  //         ref.read(packetStreamProvider.notifier).emit(packet);
  //       }
  //     } catch (_) {}
  //   }
  // }

  void _parseAndEmit(String chunk) {
    final lines = const LineSplitter().convert(chunk);
    for (final line in lines) {
      // Filter for JSON-like lines
      if (line.trim().startsWith('{')) {
        try {
          // print("PARSING: $line"); // Debug

          final json = jsonDecode(line);
          final packet = SerialPacket.fromJson(json);

          // SUCCESS!
          print(
            "CORE: Received Packet from ${packet.sender} RSSI: ${packet.rssi}",
          );

          ref.read(packetStreamProvider.notifier).emit(packet);
        } catch (e) {
          // Only print if it looked like a packet but failed
          if (line.contains("sender")) {
            print("CORE ERROR: Parse failed '$line' -> $e");
          }
        }
      }
    }
  }

  Future<void> pairSender(String receiverMac) async {
    final senderDev = state
        .where((d) => d.type == DeviceType.sender)
        .firstOrNull;
    if (senderDev != null) {
      final cmd = "PAIR:$receiverMac\n";
      senderDev.port.write(Uint8List.fromList(cmd.codeUnits));
    }
  }
}
