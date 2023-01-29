part of 'health_sync_bloc.dart';

abstract class HealthSyncEvent {
  const HealthSyncEvent();
}

///When user tries to sync with his Health App
class HealthSyncRequested extends HealthSyncEvent {}

///When user wants to disconnect access to his Health App
class HealthSyncDisconnectRequested extends HealthSyncEvent {}

class HealthSyncStarted extends HealthSyncEvent {}

class _HealthSyncStepsUpdated extends HealthSyncEvent {
  final num steps;
  const _HealthSyncStepsUpdated({required this.steps});
}

class _HealthSyncCaloriesUpdated extends HealthSyncEvent {
  final num calories;
  const _HealthSyncCaloriesUpdated({required this.calories});
}
