import 'package:flutter/material.dart';

List<Text> getDailyGoalStepValues() {
  List<Text> array = <Text>[];
  for (int i = 3000; i <= 30000; i += 500) {
    array.add(
      Text(
        i.toString(),
        style: const TextStyle(fontSize: 25),
      ),
    );
  }
  return array;
}

int calculateDailyGoalPercentage({required int dailySteps, required int dailyGoal}) {
  int result = 0;
  //CircularPercentIndicator takes in double values from 0.0 to 1.0 so if our percentage goes over 100%
  //it will crash the app so we set the maximum value at 100%
  if (dailySteps > dailyGoal && dailyGoal != 0) {
    result = 100;
  } else if (dailyGoal != 0) {
    double percentage = (dailySteps / dailyGoal) * 100;
    result = percentage.floor();
  }
  return result;
}
