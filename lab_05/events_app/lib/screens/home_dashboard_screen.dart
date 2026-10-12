import 'package:flutter/material.dart';
import '../models/exercise_model.dart';
import '../services/event_bus.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/exercise_card.dart';
import 'guide_examples_screen.dart';
import 'basic_exercises_screen.dart';
import 'intermediate_exercises_screen.dart';
import 'advanced_exercises_screen.dart';
import 'live_events_screen.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  static const List<ExerciseModel> exercises = [
    // BÁSICO
    ExerciseModel(
      number: 1,
      title: 'Cambiar Color de Fondo',
      description: 'Botón con setState que transmuta el color del contenedor y genera códigos HEX y paletas.',
      level: ExerciseLevel.basico,
      icon: Icons.palette,
      eventTags: ['onPressed', 'setState', 'AnimatedContainer'],
      targetRoute: '/basic',
    ),
    ExerciseModel(
      number: 2,
      title: 'Contador con Botones + y -',
      description: 'Contador interactivo bidireccional con botones de incremento, decremento, reset y paso configurable.',
      level: ExerciseLevel.basico,
      icon: Icons.exposure,
      eventTags: ['onPressed', 'setState', 'SegmentedButton'],
      targetRoute: '/basic',
    ),
    ExerciseModel(
      number: 3,
      title: 'Captura y Muestra de Texto',
      description: 'Captura en tiempo real con TextEditingController, onChanged, métricas de palabras y palíndromos.',
      level: ExerciseLevel.basico,
      icon: Icons.text_fields,
      eventTags: ['onChanged', 'TextEditingController', 'Chips'],
      targetRoute: '/basic',
    ),

    // INTERMEDIO
    ExerciseModel(
      number: 4,
      title: 'Formulario con Nombre y Edad',
      description: 'Captura reactiva de datos personales, cálculo de etapa biológica y credencial virtual en vivo.',
      level: ExerciseLevel.intermedio,
      icon: Icons.person_pin,
      eventTags: ['onChanged', 'Filtro de Edad', 'UI Reactiva'],
      targetRoute: '/intermediate',
    ),
    ExerciseModel(
      number: 5,
      title: 'Switch Encendido / Apagado',
      description: 'Control de interruptor con simulación de bombilla inteligente, regulación de brillo y neón.',
      level: ExerciseLevel.intermedio,
      icon: Icons.lightbulb,
      eventTags: ['onChanged (bool)', 'SwitchListTile', 'Slider'],
      targetRoute: '/intermediate',
    ),
    ExerciseModel(
      number: 6,
      title: 'Detección de Doble Clic',
      description: 'GestureDetector onDoubleTap con animación de corazón estilo red social y medidor de likes.',
      level: ExerciseLevel.intermedio,
      icon: Icons.favorite,
      eventTags: ['onDoubleTap', 'GestureDetector', 'Animación'],
      targetRoute: '/intermediate',
    ),

    // AVANZADO
    ExerciseModel(
      number: 7,
      title: 'Lista Dinámica con Agregar/Borrar',
      description: 'Gestión reactiva de ítems con categorías, prioridades, checkbox y borrado con deslizamiento (Dismissible).',
      level: ExerciseLevel.avanzado,
      icon: Icons.format_list_bulleted,
      eventTags: ['ListView.builder', 'Dismissible', 'onSubmitted'],
      targetRoute: '/advanced',
    ),
    ExerciseModel(
      number: 8,
      title: 'Validación de Formulario',
      description: 'Formulario con GlobalKey<FormState>, validadores de correo, código DNI y contraseña segura.',
      level: ExerciseLevel.avanzado,
      icon: Icons.rule_folder,
      eventTags: ['GlobalKey<FormState>', 'validator', 'AlertDialog'],
      targetRoute: '/advanced',
    ),
    ExerciseModel(
      number: 9,
      title: 'Mini-Juego de Taps Rápidos',
      description: 'Juego Speed Tap Challenge con temporizador regresivo de 10s, TPS, High Score y estados de juego.',
      level: ExerciseLevel.avanzado,
      icon: Icons.videogame_asset,
      eventTags: ['Timer.periodic', 'High Score', 'AnimatedScale'],
      targetRoute: '/advanced',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Práctica 05: Eventos e Interactividad',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInstitutionalBanner(context),
            _buildStatsOverview(context),
            _buildCategoryShortcuts(context),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Catálogo de los 9 Ejercicios Propuestos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...exercises.map(
              (ex) => ExerciseCard(
                exercise: ex,
                onTap: () => _navigateToExercise(context, ex),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildInstitutionalBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF003366), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'UNSAAC • DSI II',
                  style: TextStyle(
                    color: Color(0xFF003366),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Práctica de Laboratorio N° 5',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Manejo de Eventos e Interactividad en Flutter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Desarrollo interactivo con eventos táctiles, entradas de texto, gestión de estado con setState() y suite de 9 ejercicios resueltos.',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 14),
          const Row(
            children: [
              Icon(Icons.person, color: Colors.amber, size: 16),
              SizedBox(width: 6),
              Text(
                'Desarrollador: Yeferson Supa (220553)',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          Expanded(
            child: _statCard(
              title: 'Ejercicios',
              value: '9/9',
              subtitle: '100% Completados',
              icon: Icons.task_alt,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _statCard(
              title: 'Guía Oficial',
              value: '4 Demos',
              subtitle: 'Ejemplos + Mini Proy.',
              icon: Icons.menu_book,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LiveEventsScreen()),
                );
              },
              child: ValueListenableBuilder<int>(
                valueListenable: EventBus().totalEventsCount,
                builder: (context, count, _) {
                  return _statCard(
                    title: 'Eventos UI',
                    value: '$count',
                    subtitle: 'Ver Monitor en Vivo',
                    icon: Icons.sensors,
                    color: Colors.deepOrange,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryShortcuts(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Módulos y Niveles de Aprendizaje:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _shortcutButton(
                  context,
                  title: 'Guía Oficial',
                  icon: Icons.library_books,
                  color: Colors.indigo,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const GuideExamplesScreen()),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _shortcutButton(
                  context,
                  title: 'Básico (1-3)',
                  icon: Icons.looks_one,
                  color: Colors.teal,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const BasicExercisesScreen()),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _shortcutButton(
                  context,
                  title: 'Intermedio (4-6)',
                  icon: Icons.looks_two,
                  color: Colors.orange.shade800,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const IntermediateExercisesScreen()),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _shortcutButton(
                  context,
                  title: 'Avanzado (7-9)',
                  icon: Icons.looks_3,
                  color: Colors.deepPurple,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AdvancedExercisesScreen()),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shortcutButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.12),
        foregroundColor: color,
        elevation: 0,
        side: BorderSide(color: color.withOpacity(0.3)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _navigateToExercise(BuildContext context, ExerciseModel ex) {
    if (ex.level == ExerciseLevel.basico) {
      final tab = ex.number - 1; // 1 -> 0, 2 -> 1, 3 -> 2
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => BasicExercisesScreen(initialTabIndex: tab)),
      );
    } else if (ex.level == ExerciseLevel.intermedio) {
      final tab = ex.number - 4; // 4 -> 0, 5 -> 1, 6 -> 2
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => IntermediateExercisesScreen(initialTabIndex: tab)),
      );
    } else if (ex.level == ExerciseLevel.avanzado) {
      final tab = ex.number - 7; // 7 -> 0, 8 -> 1, 9 -> 2
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => AdvancedExercisesScreen(initialTabIndex: tab)),
      );
    }
  }
}
