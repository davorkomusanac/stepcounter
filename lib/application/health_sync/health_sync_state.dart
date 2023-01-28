part of 'health_sync_bloc.dart';

///We are using here enums for differentiating State so that we don't need to create additional classes for each State status
enum HealthSyncStatus {
  initial,
  //TODO Check if loading is necessary, if just initial or loading is enough
  loading,
  success,
  error,
}

class HealthSyncState extends Equatable {
  const HealthSyncState({
    this.status = HealthSyncStatus.initial,
    this.stepsAchievedToday = 0,
    this.caloriesBurnedToday = 0,
    this.isHealthSynced = false,
    this.errorMessage = '',
  });

  final HealthSyncStatus status;
  final num stepsAchievedToday;
  final num caloriesBurnedToday;
  final bool isHealthSynced;
  final String errorMessage;

  HealthSyncState copyWith({
    HealthSyncStatus? status,
    num? stepsAchievedToday,
    num? caloriesBurnedToday,
    bool? isHealthSynced,
    String? errorMessage,
  }) =>
      HealthSyncState(
        status: status ?? this.status,
        stepsAchievedToday: stepsAchievedToday ?? this.stepsAchievedToday,
        caloriesBurnedToday: caloriesBurnedToday ?? this.caloriesBurnedToday,
        isHealthSynced: isHealthSynced ?? this.isHealthSynced,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [
        status,
        stepsAchievedToday,
        caloriesBurnedToday,
        isHealthSynced,
        errorMessage,
      ];
}
