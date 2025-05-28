import 'dart:convert';

import 'package:app_generator_management/models/chart/generator_telemetry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

part 'base_generator_telemetry_repo.dart';

class GeneratorTelemetryRepository extends BaseGeneratorTelemetryRepository {
  final CollectionReference addressCollection =
      FirebaseFirestore.instance.collection('addresses');

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn1D() async {
    final jsonString =
        await rootBundle.loadString('json/generator_data_1_days.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList
        .map((jsonItem) => GeneratorTelemetry.fromJson(jsonItem))
        .toList();
  }

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn1H() async {
    final jsonString =
        await rootBundle.loadString('json/generator_data_1_hours.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList
        .map((jsonItem) => GeneratorTelemetry.fromJson(jsonItem))
        .toList();
  }

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn3D() async {
    final jsonString =
        await rootBundle.loadString('json/generator_data_3_days.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList
        .map((jsonItem) => GeneratorTelemetry.fromJson(jsonItem))
        .toList();
  }

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn3H() async {
    final jsonString =
        await rootBundle.loadString('json/generator_data_3_hours.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList
        .map((jsonItem) => GeneratorTelemetry.fromJson(jsonItem))
        .toList();
  }

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn7D() async {
    final jsonString =
        await rootBundle.loadString('json/generator_data_7_days.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList
        .map((jsonItem) => GeneratorTelemetry.fromJson(jsonItem))
        .toList();
  }
}
