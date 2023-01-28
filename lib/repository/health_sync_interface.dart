abstract class HealthSyncInterface {
  Stream<num> watchStepsAchievedToday();

  Stream<num> watchCaloriesBurnedToday();

  //TODO handle this
  Future<void> syncRequested();

  Future<void> disconnectRequested();
}
