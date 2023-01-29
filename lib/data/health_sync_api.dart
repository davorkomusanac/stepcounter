import 'dart:developer';

class HealthSyncApi {
  //TODO implement Health

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

  Stream<num> watchStepsAchievedToday() => Stream<num>.periodic(
        const Duration(seconds: 1),
        (value) => 100 * value,
      ).takeWhile(
        (_) => isSyncAllowed,
      );

  Stream<num> watchCaloriesBurnedToday() => Stream<num>.periodic(
        const Duration(seconds: 1),
        (value) => value + 1,
      ).takeWhile(
        (_) => isSyncAllowed,
      );
}
