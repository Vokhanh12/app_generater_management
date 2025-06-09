import 'dart:async';

import 'package:app_generator_management/models/chart/generator_telemetry.dart';
import 'package:firebase_database/firebase_database.dart';

part 'base_generator_telemetry_repo.dart';

class GeneratorTelemetryRepository extends BaseGeneratorTelemetryRepository {
  final List<GeneratorTelemetry> _generatorTelemetry = [];
  StreamSubscription<DatabaseEvent>? _subscription;

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn1H() async {
    if (_generatorTelemetry.isEmpty) return [];

    _generatorTelemetry.sort((a, b) => b.createDate.compareTo(a.createDate));
    final latestDate = _generatorTelemetry.first.createDate;

    final oneHourBefore = latestDate.subtract(const Duration(hours: 1));

    final filteredData = _generatorTelemetry
        .where((item) => item.createDate.isAfter(oneHourBefore) && item.createDate.isBefore(latestDate))
        .toList();

    print('Filtered Telemetry (1h before latest data date): $filteredData');

    return filteredData;
  }

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn3H() async {
    if (_generatorTelemetry.isEmpty) return [];

    _generatorTelemetry.sort((a, b) => b.createDate.compareTo(a.createDate));
    final latestDate = _generatorTelemetry.first.createDate;

    final threeHoursAgo = latestDate.subtract(const Duration(hours: 3));

    final recentTelemetry = _generatorTelemetry
        .where((item) =>
            item.createDate.isAfter(threeHoursAgo) &&
            item.createDate.isBefore(latestDate.add(const Duration(seconds: 1))))
        .toList();

    print('Filtered Telemetry (past 3 hours from latest data): $recentTelemetry');

    return recentTelemetry;
  }

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn1D() async {
    if (_generatorTelemetry.isEmpty) return [];

    _generatorTelemetry.sort((a, b) => b.createDate.compareTo(a.createDate));
    final latestDate = _generatorTelemetry.first.createDate;

    final oneDayAgo = latestDate.subtract(const Duration(days: 1));

    final recentTelemetry = _generatorTelemetry
        .where((item) =>
            item.createDate.isAfter(oneDayAgo) &&
            item.createDate.isBefore(latestDate.add(const Duration(seconds: 1))))
        .toList();

    print('Filtered Telemetry (past 1 day from latest data): $recentTelemetry');

    return recentTelemetry;
  }

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn3D() async {
    if (_generatorTelemetry.isEmpty) return [];

    _generatorTelemetry.sort((a, b) => b.createDate.compareTo(a.createDate));
    final latestDate = _generatorTelemetry.first.createDate;

    final threeDaysAgo = latestDate.subtract(const Duration(days: 3));

    final recentTelemetry = _generatorTelemetry
        .where((item) =>
            item.createDate.isAfter(threeDaysAgo) &&
            item.createDate.isBefore(latestDate.add(const Duration(seconds: 1))))
        .toList();

    print('Filtered Telemetry (past 3 days from latest data): $recentTelemetry');

    return recentTelemetry;
  }

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn7D() async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    final recentTelemetry = _generatorTelemetry
        .where((item) => item.createDate.isAfter(sevenDaysAgo))
        .toList();

    print('Filtered Telemetry (past 7 days): $recentTelemetry');

    return recentTelemetry;
    
  }
@override
Future<void> ListGeneratorTelemetryUpdate({
  required void Function() onRealtimeUpdate,
}) async {
  try {
    DatabaseReference ref = FirebaseDatabase.instance.ref("document");

    _subscription?.cancel();

    _subscription = ref.onValue.listen(
      (DatabaseEvent event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;

        if (data != null) {
          _generatorTelemetry.clear();

          data.forEach((key, value) {
            if (value is Map) {
              final telemetry = GeneratorTelemetry.fromMap(
                key,
                Map<String, dynamic>.from(value),
              );
              _generatorTelemetry.add(telemetry);
            }
          });

          // ✅ Sort by createDate ascending (oldest → newest)
          _generatorTelemetry.sort((a, b) => a.createDate.compareTo(b.createDate));

          print('✅ Real-time update: ${_generatorTelemetry.length} records');

          onRealtimeUpdate();
        }
      },
      onError: (error) {
        print('❌ Real-time listener error: $error');
      },
    );
  } catch (e) {
    print('❌ Error setting up real-time listener: $e');
  }
}

  @override
  Future<List<GeneratorTelemetry>> getLatest() async {
    return _generatorTelemetry;
  }

  void dispose() {
    _subscription?.cancel();
    print('🔌 Listener cancelled');
  }
}
