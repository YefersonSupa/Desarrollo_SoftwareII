import 'package:flutter/material.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/guide_examples_screen.dart';
import 'screens/basic_exercises_screen.dart';
import 'screens/intermediate_exercises_screen.dart';
import 'screens/advanced_exercises_screen.dart';
import 'screens/live_events_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EventsApp());
}

class EventsApp extends StatelessWidget {
  const EventsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Práctica 05: Eventos en Flutter - UNSAAC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003366),
          primary: const Color(0xFF003366),
          secondary: const Color(0xFF1976D2),
          surface: Colors.white,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          primary: const Color(0xFF38BDF8),
          secondary: const Color(0xFF818CF8),
          surface: const Color(0xFF1E293B),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeDashboardScreen(),
        '/guide': (context) => const GuideExamplesScreen(),
        '/basic': (context) => const BasicExercisesScreen(),
        '/intermediate': (context) => const IntermediateExercisesScreen(),
        '/advanced': (context) => const AdvancedExercisesScreen(),
        '/monitor': (context) => const LiveEventsScreen(),
      },
    );
  }
}
