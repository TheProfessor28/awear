import 'dart:async';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/vital_log_entity.dart';
import '../../../core/providers.dart';
import '../../../core/serial/serial_packet.dart';
import '../../dashboard/providers/selection_providers.dart';
import '../../devices/providers/connection_provider.dart';
import '../../users/providers/user_provider.dart';

part 'live_data_provider.g.dart';

// --- NEW PROVIDER to fix UserDashboard error ---
@riverpod
Stream<SerialPacket> selectedUserLiveVitals(SelectedUserLiveVitalsRef ref) {
  final selectedId = ref.watch(selectedUserIdProvider);
  if (selectedId == null) {
    return const Stream.empty();
  }
  // IGNORE DEPRECATION: Accessing .stream is necessary for stream delegation here
  // ignore: deprecated_member_use
  return ref.watch(liveVitalStreamProvider(selectedId).stream);
}

@riverpod
Stream<SerialPacket> liveVitalStream(
  LiveVitalStreamRef ref,
  int userId,
) async* {
  // 1. Watch the User to get their Paired Device MAC
  final userAsync = ref.watch(userNotifierProvider);

  final user = userAsync.valueOrNull?.where((u) => u.id == userId).firstOrNull;

  if (user == null || user.pairedDeviceMacAddress == null) {
    yield* Stream.empty();
    return;
  }

  final targetMac = user.pairedDeviceMacAddress!;

  // 2. IMMEDIATE: Fetch the LAST SAVED log from Database
  final isar = ref.read(isarProvider).valueOrNull;
  if (isar != null) {
    // Attempt to show the last known data while waiting for new packets
    final lastLog = await isar.vitalLogEntitys
        .filter()
        .userIdEqualTo(userId)
        .sortByTimestampDesc()
        .findFirst();

    if (lastLog != null) {
      yield SerialPacket(
        sender: targetMac,
        rssi: 0,
        id: 0,
        // FIELD MAPPING FIX: VitalLogEntity uses short names (hr), SerialPacket uses long (heartRate)
        heartRate: lastLog.hr,
        oxygen: lastLog.oxy,
        respirationRate: lastLog.rr,
        temperature: lastLog.temp,
        stress: lastLog.stress,
        // BOOL FIX: safely convert bool? to bool
        motion: lastLog.motion ?? false,
      );
    }
  }

  // 3. Listen to the Global Serial Stream
  // FIX: Access .notifier.stream to get the raw stream from a StreamNotifier
  final packetStream = ref.watch(packetStreamProvider.notifier).stream;

  // 4. Filter and Emit
  await for (final packet in packetStream) {
    if (packet.sender == targetMac) {
      _saveToHistory(ref, packet, userId);
      yield packet;
    }
  }
}

Future<void> _saveToHistory(
  LiveVitalStreamRef ref,
  SerialPacket packet,
  int userId,
) async {
  try {
    final isar = ref.read(isarProvider).valueOrNull;
    if (isar == null) return;

    // Only save if we have valid vitals
    if ((packet.heartRate ?? 0) > 0 || (packet.oxygen ?? 0) > 0) {
      final log = VitalLogEntity()
        ..userId = userId
        ..timestamp = DateTime.now()
        // FIELD MAPPING FIX: Map Packet (Long) to Entity (Short)
        ..hr = packet.heartRate
        ..oxy = packet.oxygen
        ..rr = packet.respirationRate
        ..temp = packet.temperature
        ..stress = packet.stress
        ..motion = packet.motion;

      await isar.writeTxn(() async {
        await isar.vitalLogEntitys.put(log);
      });
    }
  } catch (e) {
    // print("Error saving log: $e");
  }
}
