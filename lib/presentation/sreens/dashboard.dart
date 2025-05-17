import 'dart:async';
import 'dart:math';

import 'package:app_generator_management/models/generator_telemetry.dart';
import 'package:app_generator_management/presentation/widgets/custom_live_line_chart.dart';
import 'package:flutter/material.dart';

class DashboardSceen extends StatefulWidget {
  const DashboardSceen({super.key});

  @override
  State<DashboardSceen> createState() => _DashbroadSceenState();
}

class _DashbroadSceenState extends State<DashboardSceen> {
  late List<GeneratorTelemetry> telemetryList;

  late List<ChartData> chartDataList = [];

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    telemetryList = generateTelemetryFromMidnight();
    print(telemetryList);

    chartDataList = telemetryList.map((item) {
      return ChartData(
        time: item.timestamp,
        temperature: item.fuelLevel,
      );
    }).toList();

    generateTelemetryWithInterval(100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [CustomLiveLineChart(dataSource: chartDataList)],
      ),
    );
  }

  Future<void> generateTelemetryWithInterval(int count) async {
    final random = Random();
    DateTime currentTime = DateTime.now();

    for (int i = 0; i < count; i++) {
      final telemetry = GeneratorTelemetry(
        speed: random.nextDouble() * 3000,
        batteryVoltage: 12 + random.nextDouble() * 2,
        chargingVoltage: 13 + random.nextDouble() * 1.5,
        generatorFrequency: 49 + random.nextDouble() * 2,
        generatorVoltageL1: 220 + random.nextDouble() * 10,
        generatorVoltageL2: 220 + random.nextDouble() * 10,
        generatorVoltageL3: 220 + random.nextDouble() * 10,
        oilPressure: 30 + random.nextDouble() * 10,
        waterTemperature: 70 + random.nextDouble() * 20,
        oilTemperature: 60 + random.nextDouble() * 15,
        fuelLevel: random.nextDouble() * 100,
        timestamp: currentTime,
      );

      var data = ChartData(
        time: telemetry.timestamp,
        temperature: telemetry.fuelLevel,
      );

      setState(() {
        chartDataList.add(data);
      });

      currentTime = currentTime.add(Duration(minutes: 10));

      print("OKE: ${data.time}");

      await Future.delayed(Duration(seconds: 2));
    }
  }
}

List<GeneratorTelemetry> generateTelemetryFromMidnight() {
  final random = Random();
  final List<GeneratorTelemetry> data = [];

  final now = DateTime.now();
  final midnight = DateTime(now.year, now.month, now.day - 7, 0, 0, 0);

  // Tính tổng số khoảng 10 phút từ 00:00 đến bây giờ
  final difference = now.difference(midnight);
  final totalIntervals = difference.inMinutes ~/ 10; // chia lấy phần nguyên

  for (int i = 0; i <= totalIntervals; i++) {
    final timestamp = midnight.add(Duration(minutes: i * 10));
    data.add(GeneratorTelemetry(
      speed: random.nextDouble() * 3000,
      batteryVoltage: 12 + random.nextDouble() * 2,
      chargingVoltage: 13 + random.nextDouble() * 1.5,
      generatorFrequency: 49 + random.nextDouble() * 2,
      generatorVoltageL1: 220 + random.nextDouble() * 10,
      generatorVoltageL2: 220 + random.nextDouble() * 10,
      generatorVoltageL3: 220 + random.nextDouble() * 10,
      oilPressure: 30 + random.nextDouble() * 10,
      waterTemperature: 70 + random.nextDouble() * 20,
      oilTemperature: 60 + random.nextDouble() * 15,
      fuelLevel: random.nextDouble() * 100,
      timestamp: timestamp,
    ));
  }

  return data;
}
