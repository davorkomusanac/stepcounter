import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/health_sync_repository.dart';

part 'health_sync_event.dart';
part 'health_sync_state.dart';

class HealthSyncBloc extends Bloc<HealthSyncEvent, HealthSyncState> {
  final HealthSyncRepository healthSyncRepository;
  StreamSubscription<num>? _stepsStream;
  StreamSubscription<num>? _caloriesStream;

  HealthSyncBloc({
    required this.healthSyncRepository,
  }) : super(const HealthSyncState()) {
    on<HealthSyncRequested>(_handleHealthSyncRequested);
    on<HealthSyncDisconnectRequested>(_handleHealthSyncDisconnectRequested);
    on<HealthSyncStarted>(_handleHealthSyncStarted);
    on<_HealthSyncStepsUpdated>(_handleHealthSyncStepsUpdated);
    on<_HealthSyncCaloriesUpdated>(_handleHealthSyncCaloriesUpdated);
  }

  @override
  Future<void> close() {
    _stepsStream?.cancel();
    _caloriesStream?.cancel();
    return super.close();
  }

  Future<void> _handleHealthSyncRequested(
    HealthSyncRequested event,
    Emitter<HealthSyncState> emit,
  ) async {
    log('HealthSyncRequested called');
    try {
      final isHealthSynced = await healthSyncRepository.syncRequested();

      if (isHealthSynced) {
        add(HealthSyncStarted());
        emit(
          state.copyWith(
            status: HealthSyncStatus.success,
            isHealthSynced: isHealthSynced,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: HealthSyncStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _handleHealthSyncDisconnectRequested(
    HealthSyncDisconnectRequested event,
    Emitter<HealthSyncState> emit,
  ) async {
    log('HealthSyncDisconnectRequested called');
    try {
      final isHealthSynced = await healthSyncRepository.disconnectRequested();

      if (!isHealthSynced) {
        _stepsStream?.cancel();
        _caloriesStream?.cancel();

        emit(
          state.copyWith(
            status: HealthSyncStatus.success,
            isHealthSynced: isHealthSynced,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: HealthSyncStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _handleHealthSyncStarted(
    HealthSyncStarted event,
    Emitter<HealthSyncState> emit,
  ) async {
    log('HealthSyncUpdated called');
    _stepsStream?.cancel();
    _stepsStream = healthSyncRepository.watchStepsAchievedToday().listen(
      (steps) => add(_HealthSyncStepsUpdated(steps: steps)),
      onError: (e) {
        emit(
          state.copyWith(
            status: HealthSyncStatus.error,
            errorMessage: e.toString(),
          ),
        );
      },
    );
    _caloriesStream?.cancel();
    _caloriesStream = healthSyncRepository.watchCaloriesBurnedToday().listen(
      (calories) => add(_HealthSyncCaloriesUpdated(calories: calories)),
      onError: (e) {
        emit(
          state.copyWith(
            status: HealthSyncStatus.error,
            errorMessage: e.toString(),
          ),
        );
      },
    );
  }

  void _handleHealthSyncStepsUpdated(
    _HealthSyncStepsUpdated event,
    Emitter<HealthSyncState> emit,
  ) {
    emit(
      state.copyWith(
        status: HealthSyncStatus.success,
        stepsAchievedToday: event.steps,
      ),
    );
  }

  void _handleHealthSyncCaloriesUpdated(
    _HealthSyncCaloriesUpdated event,
    Emitter<HealthSyncState> emit,
  ) {
    emit(
      state.copyWith(
        status: HealthSyncStatus.success,
        caloriesBurnedToday: event.calories,
      ),
    );
  }
}
