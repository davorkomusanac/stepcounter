import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'daily_goal_event.dart';
part 'daily_goal_state.dart';

//It is not mentioned in the task, but I decided to use HydratedBloc to save the users daily goal
class DailyGoalBloc extends HydratedBloc<DailyGoalEvent, DailyGoalState> {
  DailyGoalBloc() : super(const DailyGoalState()) {
    on<DailyGoalChanged>(
      (event, emit) => emit(
        state.copyWith(
          dailyGoalSteps: event.dailyGoal,
        ),
      ),
    );
    on<DailyGoalNotificationButtonPressed>(
      (event, emit) => emit(
        state.copyWith(
          isNotificationDisabled: !state.isNotificationDisabled,
        ),
      ),
    );
  }

  @override
  DailyGoalState? fromJson(Map<String, dynamic> json) => DailyGoalState(
        dailyGoalSteps: json['dailyGoalSteps'] as int,
        isNotificationDisabled: json['isNotificationDisabled'] as bool,
      );

  @override
  Map<String, dynamic>? toJson(DailyGoalState state) => {
        'dailyGoalSteps': state.dailyGoalSteps,
        'isNotificationDisabled': state.isNotificationDisabled,
      };
}
