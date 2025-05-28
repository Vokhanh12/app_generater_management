part of 'generator_telemetry_bloc.dart';

enum GeneratorTelemetryType {
  none,
  oneHour,
  threeHour,
  oneDay,
  threeDays,
  sevenDays
}

abstract class GeneratorTelemetryState extends Equatable {
  final GeneratorTelemetryType type;

  const GeneratorTelemetryState(this.type);

  @override
  List<Object> get props => [type];
}

class GeneratorTelemetryInitial extends GeneratorTelemetryState {
  const GeneratorTelemetryInitial({required GeneratorTelemetryType type})
      : super(type);

  @override
  List<Object> get props => [type];
}

class GeneratorTelemetryLoading extends GeneratorTelemetryState {
  const GeneratorTelemetryLoading({required GeneratorTelemetryType type})
      : super(type);

  @override
  List<Object> get props => [type];
}

class GeneratorTelemetryLoaded extends GeneratorTelemetryState {
  final List<GeneratorTelemetry> data;

  const GeneratorTelemetryLoaded({
    required GeneratorTelemetryType type,
    required this.data,
  }) : super(type);

  @override
  List<Object> get props => [data];
}

class GeneratorTelemetryError extends GeneratorTelemetryState {
  final String message;

  const GeneratorTelemetryError({
    required GeneratorTelemetryType type,
    required this.message,
  }) : super(type);

  @override
  List<Object> get props => [message];
}
