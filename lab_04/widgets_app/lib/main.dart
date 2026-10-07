import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

/// 1. El punto de entrada oficial de toda aplicación Dart/Flutter.
/// Ejecuta la función principal y transfiere el control al framework.
void main() {
  // runApp() toma un Widget y lo convierte en la raíz del Widget Tree (Árbol de Widgets).
  runApp(const WidgetsGuideApp());
}

/// Widget raíz con soporte para gestión de estado del tema (Light / Dark Mode).
class WidgetsGuideApp extends StatefulWidget {
  const WidgetsGuideApp({super.key});

  @override
  State<WidgetsGuideApp> createState() => _WidgetsGuideAppState();
}

class _WidgetsGuideAppState extends State<WidgetsGuideApp> {
  // Estado mutable: controla si la aplicación está en modo oscuro o claro
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MaterialApp implementa el diseño visual de Material Design,
    // configurando títulos de SO, esquemas de color (ThemeData) y la ruta inicial.
    return MaterialApp(
      title: 'Guía Práctica de Widgets en Flutter - UNSAAC',
      debugShowCheckedModeBanner: false,

      // Configuración de tema claro basado en Material 3
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5E35B1), // Deep Purple institucional
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),

      // Configuración de tema oscuro basado en Material 3
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5E35B1),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),

      // Modo de tema reactivo según el switch del usuario
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // Pantalla inicial de la aplicación
      home: HomeScreen(
        onToggleTheme: _toggleTheme,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}
