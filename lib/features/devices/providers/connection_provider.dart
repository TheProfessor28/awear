import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers.dart';
import '../../../core/serial/serial_packet.dart';

part 'connection_provider.g.dart';

/// 1. Stream of Available Ports (Auto-refreshes)
@riverpod
Stream<List<String>> availablePorts(Ref ref) {
  final serial = ref.watch(serialServiceProvider);
  return serial.getAvailablePorts();
}

/// 2. Connection State Manager
@Riverpod(keepAlive: true)
class DeviceConnection extends _$DeviceConnection {
  StreamSubscription? _subscription;
  String _buffer = ""; // Stores incomplete JSON chunks

  // State = The name of the connected port (or null if disconnected)
  @override
  String? build() => null;

  Future<void> connect(String portName) async {
    final serial = ref.read(serialServiceProvider);

    try {
      await serial.connect(portName);
      state = portName;

      // Start listening to the data stream
      _subscription = serial.dataStream.listen((data) {
        _handleIncomingData(data);
      });
    } catch (e) {
      state = null;
      rethrow;
    }
  }

  Future<void> disconnect() async {
    final serial = ref.read(serialServiceProvider);
    await serial.disconnect();
    await _subscription?.cancel();
    _subscription = null;
    state = null;
  }

  /// Sends the PAIR command
  Future<void> pairDevice(String macAddress) async {
    final serial = ref.read(serialServiceProvider);
    // COMMAND FORMAT: "PAIR:AA:BB:CC:DD:EE:FF"
    await serial.sendCommand("PAIR:$macAddress\n");
  }

  /// The "Parser" Logic
  /// It takes raw chunks like '{"sen' ... 'der":...' and stitches them together.
  void _handleIncomingData(String chunk) {
    _buffer += chunk;

    // Check if we have a full line (assuming JSON ends with newline or we split by brackets)
    // A simple strategy for JSON lines: Split by newline if your device sends \n
    // Or scan for matching {}

    // Simple approach: Look for newline
    while (_buffer.contains('\n')) {
      final index = _buffer.indexOf('\n');
      final line = _buffer.substring(0, index).trim();
      _buffer = _buffer.substring(index + 1);

      if (line.isNotEmpty) {
        try {
          // 1. Parse JSON
          final json = jsonDecode(line);
          final packet = SerialPacket.fromJson(json);

          // 2. Broadcast this packet to the rest of the app
          ref.read(packetStreamProvider.notifier).emit(packet);
        } catch (e) {
          // print("Bad JSON: $line"); // Ignore malformed lines
        }
      }
    }
  }
}

/// 3. The Live Data Stream
/// This is what the UI will listen to!
@Riverpod(keepAlive: true)
class PacketStream extends _$PacketStream {
  final _controller = StreamController<SerialPacket>.broadcast();

  Stream<SerialPacket> get stream => _controller.stream;

  @override
  Stream<SerialPacket> build() {
    // Ensure we clean up when the app closes
    ref.onDispose(() => _controller.close());
    return _controller.stream;
  }

  void emit(SerialPacket packet) {
    if (!_controller.isClosed) {
      _controller.add(packet);
    }
  }
}
