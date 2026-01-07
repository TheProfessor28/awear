// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serial_packet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerialPacket _$SerialPacketFromJson(Map<String, dynamic> json) => SerialPacket(
      sender: json['sender'] as String,
      id: (json['id'] as num).toInt(),
      rssi: (json['rssi'] as num?)?.toInt() ?? 0,
      heartRate: (json['hr'] as num?)?.toDouble(),
      oxygen: (json['oxy'] as num?)?.toDouble(),
      respirationRate: (json['rr'] as num?)?.toDouble(),
      temperature: (json['temp'] as num?)?.toDouble(),
      stress: (json['stress'] as num?)?.toDouble(),
      motion: json['motion'] as bool? ?? false,
    );

Map<String, dynamic> _$SerialPacketToJson(SerialPacket instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'id': instance.id,
      'rssi': instance.rssi,
      'hr': instance.heartRate,
      'oxy': instance.oxygen,
      'rr': instance.respirationRate,
      'temp': instance.temperature,
      'stress': instance.stress,
      'motion': instance.motion,
    };
