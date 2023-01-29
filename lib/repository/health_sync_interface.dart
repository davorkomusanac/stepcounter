abstract class HealthSyncInterface {
  Stream<num> watchStepsAchievedToday();

  Stream<num> watchCaloriesBurnedToday();

  Future<void> syncRequested();

  Future<void> disconnectRequested();
}
