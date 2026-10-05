import 'package:flutter/material.dart';
import 'screens/ejercicio3_screen.dart';

void main() {
  runApp(const MiAppContador());
}

class MiAppContador extends StatelessWidget {
  const MiAppContador({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador Interactivo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Ejercicio3Screen(),
    );
  }
}
