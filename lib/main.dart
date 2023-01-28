import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/health_sync/health_sync_bloc.dart';
import 'constants/images.dart';
import 'data/health_sync_api.dart';
import 'repository/health_sync_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => RepositoryProvider<HealthSyncRepository>(
        create: (_) => HealthSyncRepository(
          healthSyncApi: HealthSyncApi(),
        ),
        child: BlocProvider<HealthSyncBloc>(
          create: (context) => HealthSyncBloc(
            healthSyncRepository: context.read<HealthSyncRepository>(),
          ),
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          ),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder<HealthSyncBloc, HealthSyncState>(
          builder: (context, state) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    ImageAssets.flameIcon,
                  ),
                ),
                if (state.status == HealthSyncStatus.error) Text(state.errorMessage),
                Text(
                  'Daily steps: ${state.stepsAchievedToday.toString()}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'Burned calories: ${state.caloriesBurnedToday.toString()}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ElevatedButton(
                  onPressed: () {
                    state.isHealthSynced
                        ? context.read<HealthSyncBloc>().add(HealthSyncDisconnectRequested())
                        : context.read<HealthSyncBloc>().add(HealthSyncRequested());
                  },
                  child: Text(
                    state.isHealthSynced ? 'Press to disconnect' : 'Press to connect',
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
