import 'package:flutter/material.dart';

void main() {
  // Punto de entrada de la aplicación móvil
  runApp(const UnsaacMobileApp());
}

/// Widget raíz de la aplicación (Stateless: estructura estática)
class UnsaacMobileApp extends StatelessWidget {
  const UnsaacMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNSAAC - Desarrollo Móvil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003366), // Azul institucional
          brightness: Brightness.light,
        ),
      ),
      home: const HolaMundoScreen(),
    );
  }
}

/// Pantalla principal interactiva (Stateful: su interfaz cambia reactivamente con el estado)
class HolaMundoScreen extends StatefulWidget {
  const HolaMundoScreen({super.key});

  @override
  State<HolaMundoScreen> createState() => _HolaMundoScreenState();
}

class _HolaMundoScreenState extends State<HolaMundoScreen> {
  int _contadorSaludos = 0;
  int _indiceMensaje = 0;

  // Al definirlo como getter o estático, Hot Reload lo actualiza instantáneamente con Ctrl+S
  List<String> get _mensajes => [
    '¡Hola mundo!📱',
    'Bienvenido a Desarrollo de Aplicaciones Móviles',
    'UNSAAC - Ingeniería Informática y de Sistemas',
    'Construido con Flutter y Dart en tiempo récord 🚀',
  ];

  void _cambiarMensaje() {
    // setState notifica a Flutter que el estado cambió y redibuja la UI
    setState(() {
      _contadorSaludos++;
      _indiceMensaje = (_indiceMensaje + 1) % _mensajes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IF616AIN - UNSAAC',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Tarjeta principal de presentación
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.smartphone_rounded,
                        size: 72,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _mensajes[_indiceMensaje],
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Producto 1: Aplicación básica "Hola Mundo móvil"',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Tarjeta informativa con los datos del curso
              Card(
                elevation: 1,
                color: theme.colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📌 Datos de la Asignatura',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      _buildInfoRow(
                        'Curso:',
                        'Desarrollo de Aplicaciones Móviles',
                      ),
                      _buildInfoRow('Código:', 'IF616AIN (2 Créditos)'),
                      _buildInfoRow(
                        'Docente:',
                        'CCACYAHUILLCA-BEJAR-HANS HARLEY',
                      ),
                      _buildInfoRow(
                        'Eje actual:',
                        'Fundamentos del desarrollo móvil',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Contador de interactividad
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'Interacciones realizadas: $_contadorSaludos',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Botón de interacción
              FilledButton.icon(
                onPressed: _cambiarMensaje,
                icon: const Icon(Icons.touch_app_rounded),
                label: const Text('Presióname para cambiar el saludo'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
