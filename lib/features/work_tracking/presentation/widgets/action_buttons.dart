import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../bloc/work_tracking_bloc.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<WorkTrackingBloc, WorkTrackingState>(
      listener: (context, state) {
        if (state is WorkTrackingActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is WorkTrackingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        bool isWorking = false;
        bool isLoading = state is WorkTrackingActionInProgress;

        if (state is WorkTrackingLoaded) {
          isWorking = state.workStatus.isWorking;
        }

        return Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: isLoading || isWorking ? null : () {
                  context.read<WorkTrackingBloc>().add(CheckInRequested());
                },
                icon: isLoading && !isWorking
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.play_arrow),
                label: Text(l10n.startWork),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: isLoading || !isWorking ? null : () {
                  context.read<WorkTrackingBloc>().add(CheckOutRequested());
                },
                icon: isLoading && isWorking
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.stop),
                label: Text(l10n.endWork),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}