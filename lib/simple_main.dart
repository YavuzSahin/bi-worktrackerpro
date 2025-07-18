import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'simple_login_page.dart';
import 'simple_dashboard_page.dart';

void main() {
  runApp(WorkTrackerApp());
}

class WorkTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkTracker Pro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('tr', ''),
      ],
      home: LoginPage(),
      routes: {
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}