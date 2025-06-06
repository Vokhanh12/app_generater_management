part of 'generator_telemetry_bloc.dart';

abstract class GeneratorTelemetryEvent extends Equatable {
  const GeneratorTelemetryEvent();

  @override
  List<Object?> get props => [];
}

class ListGeneratorTelemetryIn1H extends GeneratorTelemetryEvent {}

class ListGeneratorTelemetryIn3H extends GeneratorTelemetryEvent {}

class ListGeneratorTelemetryIn1D extends GeneratorTelemetryEvent {}

class ListGeneratorTelemetryIn3D extends GeneratorTelemetryEvent {}

class ListGeneratorTelemetryIn7D extends GeneratorTelemetryEvent {}

class ListGeneratorTelemetryUpdate extends GeneratorTelemetryEvent {}

class GeneratorTelemetryRealtimeUpdated extends GeneratorTelemetryEvent {}
