import 'package:flutter/material.dart';

import 'colors.dart';

class Styles {
  static const TextStyle title = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: AppColors.darkBlue,
  );

  static const TextStyle percentDisplay = TextStyle(
    fontSize: 49,
    fontWeight: FontWeight.w900,
    color: AppColors.darkBlue,
  );

  static const TextStyle dailyGoalStatsValue = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.softBlue,
  );

  static const TextStyle dailyGoalStatsLabel = TextStyle(
    fontSize: 14,
    color: AppColors.softBlue,
  );

  static const TextStyle dailyGoalButtonLabel = TextStyle(
    fontSize: 14,
    color: AppColors.gray,
    fontWeight: FontWeight.w600,
  );

  static ButtonStyle dailyGoalButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.fadeGray,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
  );

  static ButtonStyle synchronizeStepsButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.orange,
    //elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
  );
}
