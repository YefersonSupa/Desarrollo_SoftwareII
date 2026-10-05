import 'package:flutter/material.dart';
import 'screens/calculadora_screen.dart';

void main() {
  runApp(const MiAppCalculadora());
}

class MiAppCalculadora extends StatelessWidget {
  const MiAppCalculadora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003366),
          brightness: Brightness.light,
        ),
      ),
      home: const CalculadoraScreen(),
    );
  }
}
