import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'daily_goal_event.dart';

//It is not mentioned in the task, but I decided to use HydratedBloc to save the users daily goal
//Also there is no need for a State file since our state is just a basic int
class DailyGoalBloc extends HydratedBloc<DailyGoalEvent, int> {
  DailyGoalBloc() : super(0) {
    on<DailyGoalChanged>(
      (event, emit) => emit(event.dailyGoal),
    );
  }

  @override
  int? fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, dynamic>? toJson(int state) => {'value': state};
}
