import 'package:flutter/material.dart';

/// Ejercicio 1: Crear y Ejecutar el Primer Proyecto Flutter
/// Muestra un AppBar con título y un widget Center con texto estilizado.
class Ejercicio1Screen extends StatelessWidget {
  const Ejercicio1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica Flutter - Ejercicio 1'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flutter_dash,
              size: 80,
              color: Colors.blue,
            ),
            SizedBox(height: 24),
            Text(
              '¡Hola, Flutter!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Primer proyecto en Android Studio',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
