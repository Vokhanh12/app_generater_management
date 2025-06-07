import 'dart:async';

import 'package:app_generator_management/models/chart/generator_telemetry.dart';
import 'package:app_generator_management/repositories/category_genrator_repo/generator_telemytry_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'generator_telemetry_event.dart';

part 'generator_telemetry_state.dart';

class GeneratorTelemetryBloc
    extends Bloc<GeneratorTelemetryEvent, GeneratorTelemetryState> {
  final BaseGeneratorTelemetryRepository _generatorTelemetryRepo;
  final completer = Completer<void>();
  bool isCompleted = false;

  GeneratorTelemetryBloc({
    required BaseGeneratorTelemetryRepository generatorTelemetryRepo,
  })  : _generatorTelemetryRepo = generatorTelemetryRepo,
        super(GeneratorTelemetryInitial(
          type: GeneratorTelemetryType.none,
        )) {
    on<ListGeneratorTelemetryIn1H>((event, emit) =>
        _loadTelemetry1H(event, emit, GeneratorTelemetryType.oneHour));
    on<ListGeneratorTelemetryIn3H>((event, emit) =>
        _loadTelemetry3H(event, emit, GeneratorTelemetryType.threeHour));
    on<ListGeneratorTelemetryIn1D>((event, emit) =>
        _loadTelemetry1D(event, emit, GeneratorTelemetryType.oneDay));
    on<ListGeneratorTelemetryIn3D>((event, emit) =>
        _loadTelemetry3D(event, emit, GeneratorTelemetryType.threeDays));
    on<ListGeneratorTelemetryIn7D>((event, emit) =>
        _loadTelemetry7D(event, emit, GeneratorTelemetryType.sevenDays));
    on<ListGeneratorTelemetryUpdate>((event, emit) =>
        _loadTelemetryUpdate(event, emit, GeneratorTelemetryType.update));
    on<GeneratorTelemetryRealtimeUpdated>((event, emit) async {
      final data = await _generatorTelemetryRepo.getLatest();
      emit(GeneratorTelemetryLoaded(
        data: data,
        type: GeneratorTelemetryType.update,
      ));
      emit(GeneratorTelemetryUpdateSuccess(type: GeneratorTelemetryType.update));
    });

    _generatorTelemetryRepo.ListGeneratorTelemetryUpdate(
      onRealtimeUpdate: () {
        add(GeneratorTelemetryRealtimeUpdated());
      },
    );
  }

  Future<void> _loadTelemetry1H(
      GeneratorTelemetryEvent event,
      Emitter<GeneratorTelemetryState> emit,
      GeneratorTelemetryType generatorTelemetryType) async {
    emit(GeneratorTelemetryLoading(type: generatorTelemetryType));
    try {
      final data = await _generatorTelemetryRepo.ListGeneratorTelemetryIn1H();
      emit(GeneratorTelemetryLoaded(data: data, type: generatorTelemetryType));
    } catch (e) {
      emit(GeneratorTelemetryError(
          message: e.toString(), type: generatorTelemetryType));
    }
  }

  Future<void> _loadTelemetry3H(
      GeneratorTelemetryEvent event,
      Emitter<GeneratorTelemetryState> emit,
      GeneratorTelemetryType generatorTelemetryType) async {
    emit(GeneratorTelemetryLoading(type: generatorTelemetryType));
    try {
      final data = await _generatorTelemetryRepo.ListGeneratorTelemetryIn3H();
      emit(GeneratorTelemetryLoaded(data: data, type: generatorTelemetryType));
    } catch (e) {
      emit(GeneratorTelemetryError(
          message: e.toString(), type: generatorTelemetryType));
    }
  }

  Future<void> _loadTelemetry1D(
      GeneratorTelemetryEvent event,
      Emitter<GeneratorTelemetryState> emit,
      GeneratorTelemetryType generatorTelemetryType) async {
    emit(GeneratorTelemetryLoading(type: generatorTelemetryType));
    try {
      final data = await _generatorTelemetryRepo.ListGeneratorTelemetryIn1D();
      emit(GeneratorTelemetryLoaded(data: data, type: generatorTelemetryType));
    } catch (e) {
      emit(GeneratorTelemetryError(
          message: e.toString(), type: generatorTelemetryType));
    }
  }

  Future<void> _loadTelemetry3D(
      GeneratorTelemetryEvent event,
      Emitter<GeneratorTelemetryState> emit,
      GeneratorTelemetryType generatorTelemetryType) async {
    emit(GeneratorTelemetryLoading(type: generatorTelemetryType));
    try {
      final data = await _generatorTelemetryRepo.ListGeneratorTelemetryIn3D();
      emit(GeneratorTelemetryLoaded(data: data, type: generatorTelemetryType));
    } catch (e) {
      emit(GeneratorTelemetryError(
          message: e.toString(), type: generatorTelemetryType));
    }
  }

  Future<void> _loadTelemetry7D(
      GeneratorTelemetryEvent event,
      Emitter<GeneratorTelemetryState> emit,
      GeneratorTelemetryType generatorTelemetryType) async {
    emit(GeneratorTelemetryLoading(type: generatorTelemetryType));
    try {
      final data = await _generatorTelemetryRepo.ListGeneratorTelemetryIn7D();
      emit(GeneratorTelemetryLoaded(data: data, type: generatorTelemetryType));
    } catch (e) {
      emit(GeneratorTelemetryError(
          message: e.toString(), type: generatorTelemetryType));
    }
  }

  Future<void> _loadTelemetryUpdate(
    GeneratorTelemetryEvent event,
    Emitter<GeneratorTelemetryState> emit,
    GeneratorTelemetryType generatorTelemetryType,
  ) async {
    emit(GeneratorTelemetryLoading(type: generatorTelemetryType));

    try {
      emit(GeneratorTelemetryUpdateLoading(type: generatorTelemetryType));
      await _generatorTelemetryRepo.ListGeneratorTelemetryUpdate(
        onRealtimeUpdate: () {
          add(GeneratorTelemetryRealtimeUpdated());
        },
      );
      await completer.future;
    } catch (e) {
      emit(GeneratorTelemetryError(
        message: e.toString(),
        type: generatorTelemetryType,
      ));
    }
  }


}
