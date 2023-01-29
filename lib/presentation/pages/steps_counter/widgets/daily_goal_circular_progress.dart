import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/styles.dart';

class DailyGoalCircularProgress extends StatelessWidget {
  const DailyGoalCircularProgress({
    Key? key,
    required this.text,
    required this.percent,
  }) : super(key: key);

  final String text;
  final double percent;

  @override
  Widget build(BuildContext context) => CircularPercentIndicator(
        radius: 100,
        lineWidth: 10,
        backgroundColor: AppColors.fadeGray,
        progressColor: AppColors.orange,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          text,
          style: Styles.percentDisplay,
        ),
        percent: percent,
      );
}
