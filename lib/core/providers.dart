import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'services/sync_service.dart';
import 'database/user_entity.dart';
import 'database/device_entity.dart';
import 'database/vital_log_entity.dart';
import 'serial/serial_service_contract.dart';
import 'serial/serial_service_android.dart';
import 'serial/serial_service_windows.dart';

// This part generates the provider code automatically
part 'providers.g.dart';

/// 1. DATABASE PROVIDER
/// This opens the Isar database asynchronously.
@Riverpod(keepAlive: true)
Future<Isar> isar(Ref ref) async {
  final dir = await getApplicationDocumentsDirectory();

  if (Isar.instanceNames.isEmpty) {
    return await Isar.open(
      [UserEntitySchema, DeviceEntitySchema, VitalLogEntitySchema],
      directory: dir.path,
      inspector: true, // Allows you to inspect DB in dev mode
    );
  }

  return Isar.getInstance()!;
}

/// 2. SERIAL SERVICE PROVIDER
/// This gives the UI the correct serial implementation based on the OS.
@Riverpod(keepAlive: true)
SerialServiceContract serialService(Ref ref) {
  if (Platform.isAndroid) {
    return SerialServiceAndroid();
  } else {
    return SerialServiceWindows();
  }
}

/// 3. SYNC SERVICE PROVIDER
/// This lets us sync to Firebase.
@Riverpod(keepAlive: true)
SyncService syncService(Ref ref) {
  return SyncService();
}
