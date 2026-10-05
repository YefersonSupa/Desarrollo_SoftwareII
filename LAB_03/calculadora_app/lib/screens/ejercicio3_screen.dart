import 'package:flutter/material.dart';

/// Ejercicio 3: Contador Interactivo con StatefulWidget
/// Demuestra el uso de setState() y AnimatedDefaultTextStyle para feedback visual reactivo.
class Ejercicio3Screen extends StatefulWidget {
  const Ejercicio3Screen({super.key});

  @override
  State<Ejercicio3Screen> createState() => _Ejercicio3ScreenState();
}

class _Ejercicio3ScreenState extends State<Ejercicio3Screen> {
  int _contador = 0;

  void _incrementar() => setState(() => _contador++);
  void _decrementar() => setState(() {
        if (_contador > 0) _contador--;
      });
  void _reiniciar() => setState(() => _contador = 0);

  Color get _colorContador {
    if (_contador == 0) return Colors.grey;
    if (_contador < 5) return Colors.blue;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador Interactivo - Ejercicio 3'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Valor actual:',
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              // El color cambia según el valor numérico
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: _colorContador,
                ),
                child: Text('$_contador'),
              ),
              const SizedBox(height: 12),
              Text(
                _contador == 0
                    ? 'Estado: En reposo (Gris)'
                    : _contador < 5
                        ? 'Estado: Moderado (Azul)'
                        : 'Estado: Alto (Verde)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 40),
              // Botones de control
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: 'dec',
                    onPressed: _decrementar,
                    backgroundColor: Colors.red.shade400,
                    tooltip: 'Decrementar',
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton.extended(
                    heroTag: 'rst',
                    onPressed: _reiniciar,
                    backgroundColor: Colors.grey.shade600,
                    tooltip: 'Reiniciar a cero',
                    label: const Text(
                      'Reset',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(Icons.refresh, color: Colors.white),
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    heroTag: 'inc',
                    onPressed: _incrementar,
                    backgroundColor: Colors.green.shade500,
                    tooltip: 'Incrementar',
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
