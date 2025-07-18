import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/work_tracking/presentation/pages/mobile_dashboard_page.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isLoggedIn = authState is AuthAuthenticated;
      
      // If not logged in and trying to access protected route
      if (!isLoggedIn && state.location != '/login') {
        return '/login';
      }
      
      // If logged in and on login page, redirect to appropriate dashboard
      if (isLoggedIn && state.location == '/login') {
        final user = (authState as AuthAuthenticated).user;
        return user.isAdmin ? '/admin' : '/mobile';
      }
      
      return null; // No redirect needed
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/mobile',
        name: 'mobile',
        builder: (context, state) => const MobileDashboardPage(),
      ),
      GoRoute(
        path: '/admin',
        name: 'admin',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('Admin Dashboard (Coming Soon)'),
          ),
        ),
      ),
    ],
  );
}