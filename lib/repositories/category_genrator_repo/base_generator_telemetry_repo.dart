part of 'generator_telemytry_repo.dart';

abstract class BaseGeneratorTelemetryRepository {
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn1H();
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn3H();
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn1D();
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn3D();
  Future<List<GeneratorTelemetry>> ListGeneratorTelemetryIn7D();
  Future<void> ListGeneratorTelemetryUpdate({required void Function() onRealtimeUpdate});
  Future<List<GeneratorTelemetry>> getLatest();
}