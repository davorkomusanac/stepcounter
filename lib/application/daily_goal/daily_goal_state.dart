part of 'daily_goal_bloc.dart';

//I have decided to store both the daily goal and isNotificationDisabled inside one HydratedBloc
//So that it can both be saved, and because the Notifications are only shown when the Daily Goal is still not achieved and Notifications are enabled
class DailyGoalState extends Equatable {
  const DailyGoalState({
    this.dailyGoalSteps = 0,
    this.isNotificationDisabled = false,
  });

  final int dailyGoalSteps;
  final bool isNotificationDisabled;

  DailyGoalState copyWith({
    int? dailyGoalSteps,
    bool? isNotificationDisabled,
  }) =>
      DailyGoalState(
        dailyGoalSteps: dailyGoalSteps ?? this.dailyGoalSteps,
        isNotificationDisabled: isNotificationDisabled ?? this.isNotificationDisabled,
      );

  @override
  List<Object?> get props => [
        dailyGoalSteps,
        isNotificationDisabled,
      ];
}
