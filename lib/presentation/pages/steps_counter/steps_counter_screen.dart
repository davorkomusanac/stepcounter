import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/daily_goal/daily_goal_bloc.dart';
import '../../../application/health_sync/health_sync_bloc.dart';
import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../constants/strings.dart';
import '../../../constants/styles.dart';
import '../../../functions.dart';
import '../../../presentation/pages/steps_counter/widgets/daily_goal_exact_stats.dart';
import '../../../presentation/pages/steps_counter/widgets/steps_counter_screen_app_bar.dart';
import 'widgets/daily_goal_circular_progress.dart';
import 'widgets/daily_goal_linear_progress.dart';
import 'widgets/pick_daily_goal_button.dart';
import 'widgets/synchronize_button.dart';

class StepCounterScreen extends StatelessWidget {
  const StepCounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocConsumer<HealthSyncBloc, HealthSyncState>(
          listener: (context, state) {
            if (state.status == HealthSyncStatus.error && state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
          builder: (context, state) => BlocBuilder<DailyGoalBloc, int>(
            builder: (_, dailyGoalState) => SafeArea(
              //Column inside CustomScrollView so that we stop overflows for small devices (i.e. iPhone SE)
              //CustomScrollView is instead of SingleChildScrollView so that ModalBarrier can take up the full screen height
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const StepsCounterScreenAppBar(),
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  AppStrings.stepCounterScreenTitle,
                                  style: Styles.title,
                                ),
                              ),
                            ),
                            const SizedBox(height: 60),
                            DailyGoalCircularProgress(
                              text: '${calculateDailyGoalPercentage(
                                dailySteps: state.stepsAchievedToday.toInt(),
                                dailyGoal: dailyGoalState,
                              )}%',
                              percent: calculateDailyGoalPercentage(
                                    dailySteps: state.stepsAchievedToday.toInt(),
                                    dailyGoal: dailyGoalState,
                                  ).toDouble() /
                                  100,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  DailyGoalExactStats(
                                    imagePath: ImageAssets.stepsIcon,
                                    label: AppStrings.dailyGoalExactStepsLabel,
                                    value: '${state.stepsAchievedToday} / $dailyGoalState',
                                  ),
                                  DailyGoalExactStats(
                                    imagePath: ImageAssets.flameIcon,
                                    label: AppStrings.dailyGoalExactCaloriesLabel,
                                    value: state.caloriesBurnedToday.toString(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            const PickDailyGoalButton(),
                            const SizedBox(height: 30),
                            const Padding(
                              padding: EdgeInsets.only(right: 24.0, bottom: 2.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  //The exact flag-swallowTail icon is not present Google's Material icons so I put this replacement
                                  Icons.flag,
                                  size: 16,
                                  color: AppColors.softBlue,
                                ),
                              ),
                            ),
                            DailyGoalLinearProgress(
                                percent: calculateDailyGoalPercentage(
                                      dailySteps: state.stepsAchievedToday.toInt(),
                                      dailyGoal: dailyGoalState,
                                    ).toDouble() /
                                    100),
                            const SizedBox(height: 100),
                            //It is not shown in the design how synchronizing steps should look like so I decided
                            //to add an additional Button at the bottom of the screen to actually represent when
                            //a user wants to connect or disconnect for his synchronization
                            const SynchronizeButton(),
                          ],
                        ),
                        if (state.status == HealthSyncStatus.loading)
                          Opacity(
                            opacity: 0.8,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: const ModalBarrier(
                                dismissible: false,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        if (state.status == HealthSyncStatus.loading)
                          Container(
                            padding: const EdgeInsets.all(45),
                            decoration: BoxDecoration(
                              color: AppColors.fadeGray,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const CircularProgressIndicator(
                              color: AppColors.orange,
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
