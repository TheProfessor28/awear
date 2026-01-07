import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/serial/serial_packet.dart';
import '../../users/providers/user_provider.dart';
import 'connection_provider.dart';

part 'sender_monitor_provider.g.dart';

class SenderStatus {
  final String macAddress;
  final int rssi;
  final DateTime lastSeen;
  final bool isMoving;
  final int? assignedUserId;
  final String? assignedUserName;

  SenderStatus({
    required this.macAddress,
    required this.rssi,
    required this.lastSeen,
    required this.isMoving,
    this.assignedUserId,
    this.assignedUserName,
  });
}

@riverpod
class SenderMonitor extends _$SenderMonitor {
  @override
  List<SenderStatus> build() {
    // 1. Listen to the stream for new packets
    ref.listen(packetStreamProvider, (previous, next) {
      final packet = next.valueOrNull;
      if (packet != null) {
        final users = ref.read(userNotifierProvider).valueOrNull ?? [];
        _processPacket(packet, users);
      }
    });

    // 2. Set up a Timer to prune old devices every 2 seconds
    final timer = Timer.periodic(const Duration(seconds: 2), (_) {
      pruneOldDevices();
    });

    // 3. Ensure the timer stops when this provider is no longer used
    ref.onDispose(() {
      timer.cancel();
    });

    return [];
  }

  void _processPacket(SerialPacket packet, List<dynamic> users) {
    // Use 'packet.sender' (matches your SerialPacket class)
    final currentMac = packet.sender;

    // Find Owner
    int? userId;
    String? userName;
    final owner = users
        .where((u) => u.pairedDeviceMacAddress == currentMac)
        .firstOrNull;

    if (owner != null) {
      userId = owner.id;
      userName = "${owner.firstName} ${owner.lastName}";
    }

    // Check if device exists
    final index = state.indexWhere((s) => s.macAddress == currentMac);

    final newStatus = SenderStatus(
      macAddress: currentMac,
      rssi: packet.rssi, // Matches the new field in SerialPacket
      lastSeen: DateTime.now(),
      isMoving: packet.motion,
      assignedUserId: userId,
      assignedUserName: userName,
    );

    // Update State
    if (index >= 0) {
      final newState = [...state];
      newState[index] = newStatus;
      state = newState;
    } else {
      state = [...state, newStatus];
    }
  }

  void pruneOldDevices() {
    final now = DateTime.now();
    // Remove devices that haven't been seen in the last 10 seconds
    final newState = state
        .where((s) => now.difference(s.lastSeen).inSeconds < 10)
        .toList();

    // Only trigger a rebuild if the list size actually changed
    if (newState.length != state.length) {
      state = newState;
    }
  }
}
