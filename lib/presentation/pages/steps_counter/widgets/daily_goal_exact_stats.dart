import 'package:flutter/material.dart';

import '../../../../constants/styles.dart';

class DailyGoalExactStats extends StatelessWidget {
  const DailyGoalExactStats({
    required this.imagePath,
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  final String label;
  final String value;
  final String imagePath;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Image.asset(imagePath),
          const SizedBox(height: 8),
          Text(
            value,
            style: Styles.dailyGoalStatsValue,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Styles.dailyGoalStatsLabel,
          ),
        ],
      );
}
