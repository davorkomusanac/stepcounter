import 'dart:developer';

class HealthSyncApi {
  ///I have decided to mock the Health Data based on https://pub.dev/packages/health for several reasons.
  ///
  ///With mocking the Health Data I can more easily show changes on the UI
  ///I can also more easily video record the results
  ///
  ///And also, there is the aspect of time and development speed. Based on the due date (end of the weekend)
  ///I had to make a choice at deciding what are the most important features to implement inside the app
  ///during the allotted time and on which scale to implement them

  bool isSyncAllowed = false;

  Future<bool> syncRequested() async {
    try {
      log('api syncRequested');
      await Future.delayed(
        const Duration(seconds: 1),
      );
      return isSyncAllowed = true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> disconnectRequested() async {
    try {
      log('api disconnectRequested');
      await Future.delayed(
        const Duration(seconds: 1),
      );
      return isSyncAllowed = false;
    } catch (e) {
      rethrow;
    }
  }

  ///I have created two streams, one for Steps, one for Calories, because of the api in https://pub.dev/packages/health
  ///It separates calories and steps so I decided to do it here also to stay as much faithful to the api
  Stream<num> watchStepsAchievedToday() => Stream<num>.periodic(
        const Duration(milliseconds: 500),
        (value) => 100 * value,
      ).takeWhile(
        (_) => isSyncAllowed,
      );

  Stream<num> watchCaloriesBurnedToday() => Stream<num>.periodic(
        const Duration(milliseconds: 500),
        (value) => value + 1,
      ).takeWhile(
        (_) => isSyncAllowed,
      );
}
