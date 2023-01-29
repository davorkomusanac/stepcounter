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
  runApp(const MyApp());
}

//TODO edit README inside app to explain some architecture decisions and choices
//Explain what was the logic, how some widgets were made to save time, etc.
//Also show a .gif inside readme where they can see how it looks like.
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
