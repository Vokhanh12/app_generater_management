import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GeneratorTelemetry extends Equatable {
  final double speed;
  final double batteryVoltage;
  final double chargingVoltage;
  final double generatorFrequency;

  final double generatorVoltageL1;
  final double generatorVoltageL2;
  final double generatorVoltageL3;

  final double oilPressure;
  final double waterTemperature;
  final double oilTemperature;

  final double fuelLevel;

  final DateTime timestamp;

  const GeneratorTelemetry({
    required this.speed,
    required this.batteryVoltage,
    required this.chargingVoltage,
    required this.generatorFrequency,
    required this.generatorVoltageL1,
    required this.generatorVoltageL2,
    required this.generatorVoltageL3,
    required this.oilPressure,
    required this.waterTemperature,
    required this.oilTemperature,
    required this.fuelLevel,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        speed,
        batteryVoltage,
        chargingVoltage,
        generatorFrequency,
        generatorVoltageL1,
        generatorVoltageL2,
        generatorVoltageL3,
        oilPressure,
        waterTemperature,
        oilTemperature,
        fuelLevel,
        timestamp,
      ];

  factory GeneratorTelemetry.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return GeneratorTelemetry(
      speed: (data['speed'] ?? 0).toDouble(),
      batteryVoltage: (data['batteryVoltage'] ?? 0).toDouble(),
      chargingVoltage: (data['chargingVoltage'] ?? 0).toDouble(),
      generatorFrequency: (data['generatorFrequency'] ?? 0).toDouble(),
      generatorVoltageL1: (data['generatorVoltageL1'] ?? 0).toDouble(),
      generatorVoltageL2: (data['generatorVoltageL2'] ?? 0).toDouble(),
      generatorVoltageL3: (data['generatorVoltageL3'] ?? 0).toDouble(),
      oilPressure: (data['oilPressure'] ?? 0).toDouble(),
      waterTemperature: (data['waterTemperature'] ?? 0).toDouble(),
      oilTemperature: (data['oilTemperature'] ?? 0).toDouble(),
      fuelLevel: (data['fuelLevel'] ?? 0).toDouble(),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'speed': speed,
      'batteryVoltage': batteryVoltage,
      'chargingVoltage': chargingVoltage,
      'generatorFrequency': generatorFrequency,
      'generatorVoltageL1': generatorVoltageL1,
      'generatorVoltageL2': generatorVoltageL2,
      'generatorVoltageL3': generatorVoltageL3,
      'oilPressure': oilPressure,
      'waterTemperature': waterTemperature,
      'oilTemperature': oilTemperature,
      'fuelLevel': fuelLevel,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
