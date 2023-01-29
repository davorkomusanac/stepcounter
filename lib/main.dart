import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'application/daily_goal/daily_goal_bloc.dart';
import 'application/health_sync/health_sync_bloc.dart';
import 'constants/strings.dart';
import 'constants/theme.dart';
import 'data/health_sync_api.dart';
import 'presentation/pages/steps_counter/steps_counter_screen.dart';
import 'repository/health_sync_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  AwesomeNotifications().initialize(
    //passing null so that default app icon is used
    null,
    [
      NotificationChannel(
        channelGroupKey: AppStrings.awesomeNotificationChannelGroupKey,
        channelKey: AppStrings.awesomeNotificationChannelKey,
        channelName: AppStrings.awesomeNotificationChannelName,
        channelDescription: AppStrings.awesomeNotificationChannelDescription,
      )
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => RepositoryProvider<HealthSyncRepository>(
        //Using RepositoryProvider for Dependency Injection
        create: (_) => HealthSyncRepository(
          healthSyncApi: HealthSyncApi(),
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HealthSyncBloc>(
              create: (context) => HealthSyncBloc(
                healthSyncRepository: context.read<HealthSyncRepository>(),
              ),
            ),
            BlocProvider<DailyGoalBloc>(
              create: (context) => DailyGoalBloc(),
            ),
          ],
          child: MaterialApp(
            title: AppStrings.appName,
            theme: theme,
            home: const StepCounterScreen(),
          ),
        ),
      );
}
