import 'dart:async';
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

/// 2. The Live Data Stream
/// This is what the UI will listen to for incoming sensor data!
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
