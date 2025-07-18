import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/models/work_log.dart';
import '../bloc/work_tracking_bloc.dart';

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.history,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.recentActivity,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<WorkTrackingBloc, WorkTrackingState>(
              builder: (context, state) {
                if (state is WorkTrackingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                
                if (state is WorkTrackingLoaded) {
                  final recentLogs = state.workLogs.take(5).toList();
                  
                  if (recentLogs.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        'No recent activity',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return Column(
                    children: recentLogs.map((log) => _ActivityItem(
                      workLog: log,
                      l10n: l10n,
                    )).toList(),
                  );
                }

                return Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Unable to load activities',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final WorkLog workLog;
  final AppLocalizations l10n;

  const _ActivityItem({
    required this.workLog,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat.Hm();
    final dateFormat = DateFormat.MMMd();
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: workLog.isCheckIn ? Colors.green.shade100 : Colors.red.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              workLog.isCheckIn ? Icons.login : Icons.logout,
              color: workLog.isCheckIn ? Colors.green : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workLog.isCheckIn ? l10n.startedWork : l10n.endedWork,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${timeFormat.format(workLog.timestamp)} • ${dateFormat.format(workLog.timestamp)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                if (workLog.locationName != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 12,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          workLog.locationName!,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}