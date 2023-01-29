import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/daily_goal/daily_goal_bloc.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/strings.dart';
import '../../../../constants/styles.dart';
import '../../../../functions.dart';

class PickDailyGoalButton extends StatelessWidget {
  const PickDailyGoalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () {
          //The design didn't say how choosing a Daily Goal is supposed to function so I made the decision myself
          //Using BottomPicker package to show a BottomPicker containing step values in a range from 3000 to 30 000 with increments of 500
          BottomPicker(
            items: getDailyGoalStepValues(),
            selectedItemIndex: 5,
            title: AppStrings.bottomPickerTitle,
            titleStyle: const TextStyle(
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
            descriptionStyle: const TextStyle(
              color: AppColors.softBlue,
            ),
            description: AppStrings.bottomPickerDescription,
            iconColor: AppColors.darkBlue,
            onSubmit: (index) {
              String? dailyGoalString = getDailyGoalStepValues().elementAt(index).data;
              int dailyGoal = int.tryParse(dailyGoalString ?? '0') ?? 0;
              context.read<DailyGoalBloc>().add(
                    DailyGoalChanged(dailyGoal: dailyGoal),
                  );
            },
          ).show(context);
        },
        style: Styles.dailyGoalButtonStyle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.edit,
              size: 16,
              color: AppColors.gray,
            ),
            SizedBox(width: 10),
            Text(
              AppStrings.dailyGoalButtonText,
              style: Styles.dailyGoalButtonLabel,
            ),
          ],
        ),
      );
}
