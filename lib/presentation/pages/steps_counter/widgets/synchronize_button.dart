import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/health_sync/health_sync_bloc.dart';
import '../../../../constants/strings.dart';
import '../../../../constants/styles.dart';

class SynchronizeButton extends StatelessWidget {
  const SynchronizeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<HealthSyncBloc, HealthSyncState>(
        builder: (context, state) => ElevatedButton(
          onPressed: () {
            state.isHealthSynced
                ? context.read<HealthSyncBloc>().add(HealthSyncDisconnectRequested())
                : context.read<HealthSyncBloc>().add(HealthSyncRequested());
          },
          style: Styles.synchronizeStepsButtonStyle,
          child: Text(
            state.isHealthSynced ? AppStrings.healthDisconnectButtonText : AppStrings.healthSyncButtonText,
          ),
        ),
      );
}
