import 'package:json_annotation/json_annotation.dart';

part 'serial_packet.g.dart';

@JsonSerializable()
class SerialPacket {
  final String sender; // MAC Address
  final int id;

  @JsonKey(defaultValue: 0) // Default to 0 if missing
  final int rssi;

  @JsonKey(name: 'hr')
  final double? heartRate;

  @JsonKey(name: 'oxy')
  final double? oxygen;

  @JsonKey(name: 'rr')
  final double? respirationRate;

  @JsonKey(name: 'temp')
  final double? temperature;

  @JsonKey(name: 'stress')
  final double? stress;

  @JsonKey(defaultValue: false)
  final bool motion;

  SerialPacket({
    required this.sender,
    required this.id,
    required this.rssi,
    this.heartRate,
    this.oxygen,
    this.respirationRate,
    this.temperature,
    this.stress,
    this.motion = false,
  });

  factory SerialPacket.fromJson(Map<String, dynamic> json) =>
      _$SerialPacketFromJson(json);
  Map<String, dynamic> toJson() => _$SerialPacketToJson(this);
}
