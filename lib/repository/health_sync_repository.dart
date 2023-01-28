import 'dart:developer';

import '../data/health_sync_api.dart';
import 'health_sync_interface.dart';

class HealthSyncRepository implements HealthSyncInterface {
  final HealthSyncApi healthSyncApi;

  HealthSyncRepository({required this.healthSyncApi});

  @override
  Future<bool> disconnectRequested() async {
    try {
      return await healthSyncApi.disconnectRequested();
    } catch (e) {
      log(e.toString());
      //TODO Check error message here and put some constant message
      throw 'Some Error While Disconnecting';
    }
  }

  @override
  Future<bool> syncRequested() async {
    try {
      return await healthSyncApi.syncRequested();
    } catch (e) {
      log(e.toString());
      //TODO Check error message here and put some constant message
      throw 'Some Error While Requesting';
    }
  }

  @override
  Stream<num> watchCaloriesBurnedToday() => healthSyncApi.watchCaloriesBurnedToday().handleError(
        (e) {
          log(e.toString());
          throw 'Some error while calling calories';
        },
      );

  @override
  Stream<num> watchStepsAchievedToday() => healthSyncApi.watchStepsAchievedToday().handleError(
        (e) {
          log(e.toString());
          throw 'Some error while calling steps';
        },
      );
}
