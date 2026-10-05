import 'package:flutter/material.dart';
import 'screens/ejercicio1_screen.dart';
import 'screens/ejercicio2_screen.dart';
import 'screens/ejercicio3_screen.dart';
import 'screens/calculadora_screen.dart';

void main() {
  runApp(const Laboratorio03App());
}

/// Aplicación principal del Laboratorio 03 / Práctica 1:
/// "Introducción a Flutter en Android Studio" - UNSAAC
/// Permite navegar entre todos los ejercicios guiados y el ejercicio propuesto.
class Laboratorio03App extends StatelessWidget {
  const Laboratorio03App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNSAAC - Lab 03 Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003366), // Azul institucional UNSAAC
          brightness: Brightness.light,
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0; // Calculadora por defecto (Ejercicio Propuesto)

  final List<Widget> _screens = const [
    CalculadoraScreen(),
    Ejercicio1Screen(),
    Ejercicio2Screen(),
    Ejercicio3Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: 'Calculadora',
          ),
          NavigationDestination(
            icon: Icon(Icons.waving_hand_outlined),
            selectedIcon: Icon(Icons.waving_hand),
            label: 'Ej. 1: Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Ej. 2: Perfil',
          ),
          NavigationDestination(
            icon: Icon(Icons.exposure_plus_1_outlined),
            selectedIcon: Icon(Icons.exposure_plus_1),
            label: 'Ej. 3: Contador',
          ),
        ],
      ),
    );
  }
}
