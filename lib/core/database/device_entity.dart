import 'package:isar/isar.dart';

part 'device_entity.g.dart';

@collection
class DeviceEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String macAddress; // The "sender" ID from JSON

  late DateTime lastSeen;

  // Helper to quickly check if this device is known/assigned
  bool isPaired = false;
}
