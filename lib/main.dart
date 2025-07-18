import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/api_service.dart';
import 'core/services/storage_service.dart';
import 'core/services/location_service.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/work_tracking/presentation/bloc/work_tracking_bloc.dart';
import 'core/l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  final prefs = await SharedPreferences.getInstance();
  final storageService = StorageService(prefs);
  final apiService = ApiService();
  final locationService = LocationService();
  
  runApp(WorkTrackerApp(
    storageService: storageService,
    apiService: apiService,
    locationService: locationService,
  ));
}

class WorkTrackerApp extends StatelessWidget {
  final StorageService storageService;
  final ApiService apiService;
  final LocationService locationService;

  const WorkTrackerApp({
    super.key,
    required this.storageService,
    required this.apiService,
    required this.locationService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: storageService),
        RepositoryProvider.value(value: apiService),
        RepositoryProvider.value(value: locationService),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              apiService: apiService,
              storageService: storageService,
            )..add(AuthCheckRequested()),
          ),
          BlocProvider(
            create: (context) => WorkTrackingBloc(
              apiService: apiService,
              locationService: locationService,
            ),
          ),
        ],
        child: MaterialApp.router(
          title: 'WorkTracker Pro',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: AppRouter.router,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('tr', ''),
            Locale('es', ''),
            Locale('pt', ''),
            Locale('ar', ''),
          ],
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}