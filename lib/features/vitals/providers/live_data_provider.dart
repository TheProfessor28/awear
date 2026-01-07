import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../dashboard/providers/selection_providers.dart';
import '../../devices/providers/connection_provider.dart';
import '../../users/providers/user_provider.dart';
import '../../../core/serial/serial_packet.dart';

part 'live_data_provider.g.dart';

@riverpod
Stream<SerialPacket?> selectedUserLiveVitals(Ref ref) async* {
  // 1. Who is selected?
  final selectedId = ref.watch(selectedUserIdProvider);
  if (selectedId == null) {
    yield null;
    return;
  }

  // 2. Get the User object to find their MAC address
  final users = await ref.watch(userNotifierProvider.future);
  final user = users.where((u) => u.id == selectedId).firstOrNull;

  if (user == null || user.pairedDeviceMacAddress == null) {
    yield null;
    return;
  }

  // 3. Listen to the MAIN packet stream
  // FIX: Watch .stream to get the actual Stream object, not the AsyncValue
  final packetStream = ref.watch(packetStreamProvider.notifier).stream;

  // 4. Filter: Only yield packets that match this user's device
  await for (final packet in packetStream) {
    if (packet.sender == user.pairedDeviceMacAddress) {
      yield packet;
    }
  }
}
