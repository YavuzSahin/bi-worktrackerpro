import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../bloc/work_tracking_bloc.dart';

class WorkStatsGrid extends StatelessWidget {
  const WorkStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<WorkTrackingBloc, WorkTrackingState>(
      builder: (context, state) {
        // Calculate stats from work logs
        String todayHours = "0h 0m";
        String weekHours = "0h 0m"; 
        String monthHours = "0h 0m";

        if (state is WorkTrackingLoaded) {
          final logs = state.workLogs;
          final now = DateTime.now();
          
          // Calculate today's hours
          final todayStart = DateTime(now.year, now.month, now.day);
          final todayLogs = logs.where((log) => 
            log.timestamp.isAfter(todayStart)
          ).toList();
          todayHours = _calculateHours(todayLogs);

          // Calculate this week's hours  
          final weekStart = now.subtract(Duration(days: now.weekday - 1));
          final weekStartDay = DateTime(weekStart.year, weekStart.month, weekStart.day);
          final weekLogs = logs.where((log) =>
            log.timestamp.isAfter(weekStartDay)
          ).toList();
          weekHours = _calculateHours(weekLogs);

          // Calculate this month's hours
          final monthStart = DateTime(now.year, now.month, 1);
          final monthLogs = logs.where((log) =>
            log.timestamp.isAfter(monthStart)
          ).toList();
          monthHours = _calculateHours(monthLogs);
        }

        return GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _StatCard(
              title: l10n.todayHours,
              value: todayHours,
              icon: Icons.today,
              color: Colors.blue,
            ),
            _StatCard(
              title: l10n.thisWeek,
              value: weekHours,
              icon: Icons.date_range,
              color: Colors.orange,
            ),
            _StatCard(
              title: l10n.thisMonth,
              value: monthHours,
              icon: Icons.calendar_month,
              color: Colors.purple,
            ),
          ],
        );
      },
    );
  }

  String _calculateHours(List<dynamic> logs) {
    // Simplified calculation - in a real app you'd properly pair check-ins with check-outs
    double totalMinutes = logs.length * 30.0; // Placeholder calculation
    int hours = (totalMinutes / 60).floor();
    int minutes = (totalMinutes % 60).round();
    return "${hours}h ${minutes}m";
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}