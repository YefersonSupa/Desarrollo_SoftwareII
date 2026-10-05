import 'package:flutter/material.dart';
import 'screens/ejercicio2_screen.dart';

void main() {
  runApp(const MiAppPerfil());
}

class MiAppPerfil extends StatelessWidget {
  const MiAppPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarjeta de Perfil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Ejercicio2Screen(),
    );
  }
}
