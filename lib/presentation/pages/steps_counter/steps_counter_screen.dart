import 'package:awesome_notifications/awesome_notifications.dart';
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

class StepCounterScreen extends StatefulWidget {
  const StepCounterScreen({Key? key}) : super(key: key);

  @override
  State<StepCounterScreen> createState() => _StepCounterScreenState();
}

class _StepCounterScreenState extends State<StepCounterScreen> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  void handleNotification() {
    //Get currentDateTime and if on the current day it is less than 8 p.m. then schedule a notification
    DateTime currentDateTime = DateTime.now();
    AwesomeNotifications().cancelAll();
    if (currentDateTime.hour < 20) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: AppStrings.awesomeNotificationChannelKey,
          title: AppStrings.awesomeNotificationTitle,
          body: AppStrings.awesomeNotificationBody,
        ),
        schedule: NotificationCalendar.fromDate(
          date: DateTime(
            currentDateTime.year,
            currentDateTime.month,
            currentDateTime.day,
            20,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<DailyGoalBloc, DailyGoalState>(
          builder: (_, dailyGoalState) => BlocConsumer<HealthSyncBloc, HealthSyncState>(
            listener: (context, state) {
              //Since it was mentioned that for the purposes of this task I should not use any cloud push services
              //I have to use local notifications, which forces me to make a "workaround"
              //
              //Logic is as follows: Since local notifications cannot be pushed based on any logic except scheduling an interval
              //I have to resort to basically continuously check when the user opens the app and compare if his current steps are less than the daily goal
              //If so, then create a notification which will be scheduled at the prescribed datetime
              //If it isn't, then cancel the notification.
              //
              //I have also implemented the notification button with which user can block or turn on back notification inside the app
              if (!dailyGoalState.isNotificationDisabled) {
                if (state.stepsAchievedToday < dailyGoalState.dailyGoalSteps) {
                  handleNotification();
                } else if (state.stepsAchievedToday >= dailyGoalState.dailyGoalSteps) {
                  AwesomeNotifications().cancelAll();
                }
              }

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
            builder: (context, state) => SafeArea(
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
                                dailyGoal: dailyGoalState.dailyGoalSteps,
                              )}%',
                              percent: calculateDailyGoalPercentage(
                                    dailySteps: state.stepsAchievedToday.toInt(),
                                    dailyGoal: dailyGoalState.dailyGoalSteps,
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
                                    value: '${state.stepsAchievedToday} / ${dailyGoalState.dailyGoalSteps}',
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
                                      dailyGoal: dailyGoalState.dailyGoalSteps,
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
