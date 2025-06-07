import 'dart:async';

import 'package:app_generator_management/models/chart/generator_telemetry.dart';
import 'package:firebase_database/firebase_database.dart';

part 'base_generator_telemetry_repo.dart';

class GeneratorTelemetryRepository extends BaseGeneratorTelemetryRepository {
  final List<GeneratorTelemetry> _generatorTelemetry = [];
  StreamSubscription<DatabaseEvent>? _subscription;

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn1H() async {
    final now = DateTime.now();
    final oneHourAgo = now.subtract(const Duration(hours: 1));

    final recentTelemetry = _generatorTelemetry
        .where((item) => item.createDate.isAfter(oneHourAgo))
        .toList();

    print('Filtered Telemetry (past 1 hour): $recentTelemetry');

    return recentTelemetry;
  }

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn3H() async {
    final now = DateTime.now();
    final threeHoursAgo = now.subtract(const Duration(hours: 3));

    final recentTelemetry = _generatorTelemetry
        .where((item) => item.createDate.isAfter(threeHoursAgo))
        .toList();

    print('Filtered Telemetry (past 3 hours): $recentTelemetry');

    return recentTelemetry;
  }

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn1D() async {
    final now = DateTime.now();
    final oneDayAgo = now.subtract(const Duration(days: 1));

    final recentTelemetry = _generatorTelemetry
        .where((item) => item.createDate.isAfter(oneDayAgo))
        .toList();

    print('Filtered Telemetry (past 1 day): $recentTelemetry');

    return recentTelemetry;
  }

  @override
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn3D() async {
    final now = DateTime.now();
    final threeDaysAgo = now.subtract(const Duration(days: 3));

    final recentTelemetry = _generatorTelemetry
        .where((item) => item.createDate.isAfter(threeDaysAgo))
        .toList();

    print('Filtered Telemetry (past 3 days): $recentTelemetry');

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
