import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/models/user.dart';
import '../../presentation/bloc/work_tracking_bloc.dart';
import '../widgets/work_status_card.dart';
import '../widgets/action_buttons.dart';
import '../widgets/recent_activity_card.dart';
import '../widgets/work_stats_grid.dart';

class MobileDashboardPage extends StatefulWidget {
  const MobileDashboardPage({super.key});

  @override
  State<MobileDashboardPage> createState() => _MobileDashboardPageState();
}

class _MobileDashboardPageState extends State<MobileDashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<WorkTrackingBloc>().add(WorkStatusRequested());
    context.read<WorkTrackingBloc>().add(WorkLogsRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<WorkTrackingBloc>().add(WorkStatusRequested());
          context.read<WorkTrackingBloc>().add(WorkLogsRequested());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Greeting Header
              _buildGreetingHeader(context),
              const SizedBox(height: 24),
              
              // Current Status Card
              const WorkStatusCard(),
              const SizedBox(height: 24),
              
              // Action Buttons
              const ActionButtons(),
              const SizedBox(height: 24),
              
              // Work Stats Grid
              const WorkStatsGrid(),
              const SizedBox(height: 24),
              
              // Recent Activity
              const RecentActivityCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final timeFormat = DateFormat.Hm();
    final dateFormat = DateFormat.yMMMMEEEEd();
    
    String greeting;
    final hour = now.hour;
    if (hour < 12) {
      greeting = l10n.goodMorning;
    } else if (hour < 17) {
      greeting = l10n.goodAfternoon;
    } else {
      greeting = l10n.goodEvening;
    }

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = (state is AuthAuthenticated) ? state.user : null;
        
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greeting,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (user != null)
                          Text(
                            user.fullName,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        timeFormat.format(now),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        dateFormat.format(now),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}