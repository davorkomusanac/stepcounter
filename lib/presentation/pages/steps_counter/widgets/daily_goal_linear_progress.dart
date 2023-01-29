import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../constants/colors.dart';

class DailyGoalLinearProgress extends StatelessWidget {
  const DailyGoalLinearProgress({
    Key? key,
    required this.percent,
  }) : super(key: key);

  final double percent;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //It is not really clear in the design or the UserStories what the LinearIndicator is supposed to represent.
        //In the design the number of steps doesn't fit for the percentage on the indicators.
        //So I decided to have it also represent the percentage of the daily goal filled.
        child: LinearPercentIndicator(
          lineHeight: 10,
          barRadius: const Radius.circular(5),
          backgroundColor: AppColors.fadeGray,
          progressColor: AppColors.orange,
          percent: percent,
        ),
      );
}
