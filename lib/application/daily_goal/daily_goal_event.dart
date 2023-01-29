part of 'daily_goal_bloc.dart';

abstract class DailyGoalEvent {}

class DailyGoalChanged extends DailyGoalEvent {
  final int dailyGoal;
  DailyGoalChanged({required this.dailyGoal});
}

class DailyGoalNotificationButtonPressed extends DailyGoalEvent {}
