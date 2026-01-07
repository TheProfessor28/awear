import 'package:isar/isar.dart';

part 'vital_log_entity.g.dart';

@collection
class VitalLogEntity {
  Id id = Isar.autoIncrement;

  @Index()
  late int userId; // Link to UserEntity.id

  @Index()
  late DateTime timestamp;

  // Vitals Data
  double? hr; // Heart Rate
  double? oxy; // Oxygen
  double? rr; // Respiration Rate
  double? temp; // Temperature
  double? stress; // Stress Level
  bool? motion; // Motion detection
}
