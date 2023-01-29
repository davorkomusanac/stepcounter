import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/daily_goal/daily_goal_bloc.dart';
import '../../../../constants/colors.dart';

class StepsCounterScreenAppBar extends StatelessWidget {
  const StepsCounterScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                log('back button called, not implemented since there is only one screen currently');
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.darkBlue,
                size: 26,
              ),
            ),
            BlocBuilder<DailyGoalBloc, DailyGoalState>(
              builder: (context, state) => IconButton(
                onPressed: () {
                  context.read<DailyGoalBloc>().add(
                        DailyGoalNotificationButtonPressed(),
                      );
                  AwesomeNotifications().cancelAll();
                },
                icon: Icon(
                  state.isNotificationDisabled ? Icons.notifications_active : Icons.notifications_off_outlined,
                  color: AppColors.darkBlue,
                  size: 26,
                ),
              ),
            ),
          ],
        ),
      );
}
