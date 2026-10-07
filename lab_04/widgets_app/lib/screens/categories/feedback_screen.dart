import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/widgets_data.dart';
import '../../widgets/widget_demo_card.dart';

enum _ProgressDisplayMode { continuous, simulated, manual }

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  // Estados ProgressIndicator
  _ProgressDisplayMode _progressMode = _ProgressDisplayMode.continuous;
  double _manualProgress = 0.65;
  double _simulatedProgress = 0.0;
  bool _isSimulating = false;
  Timer? _simulationTimer;

  // Estados AlertDialog
  String _dialogDecision = 'Ninguna todavía';
  bool _barrierDismissible = true;

  // Estados Chip & FilterChip
  final Set<String> _selectedChips = {'Flutter', 'Dart'};
  final List<String> _removableTags = ['Widget', 'State', 'Context', 'Hot Reload'];

  @override
  void dispose() {
    _simulationTimer?.cancel();
    super.dispose();
  }

  void _startSimulation() {
    _simulationTimer?.cancel();
    setState(() {
      _simulatedProgress = 0.0;
      _isSimulating = true;
    });
    _simulationTimer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _simulatedProgress += 0.02;
        if (_simulatedProgress >= 1.0) {
          _simulatedProgress = 1.0;
          _isSimulating = false;
          timer.cancel();
        }
      });
    });
  }

  void _stopSimulation() {
    _simulationTimer?.cancel();
    _isSimulating = false;
  }

  String _getSimulationMessage() {
    if (_simulatedProgress >= 1.0) {
      return '¡Carga completada con éxito al 100%! ✓';
    } else if (_simulatedProgress >= 0.70) {
      return 'Renderizando e inflando widgets... (${(_simulatedProgress * 100).toInt()}%)';
    } else if (_simulatedProgress >= 0.35) {
      return 'Descargando datos del servidor... (${(_simulatedProgress * 100).toInt()}%)';
    } else {
      return 'Iniciando conexión y recursos... (${(_simulatedProgress * 100).toInt()}%)';
    }
  }

  @override
  Widget build(BuildContext context) {
    final widgets = kWidgetsList.where((w) => w.category.name == 'feedback').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets de Feedback (4)'),
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: const Color(0xFFFFEBEE),
            margin: const EdgeInsets.only(bottom: 16),
            child: const Padding(
              padding: EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(Icons.notifications_active, color: Color(0xFFE53935), size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Los widgets de Feedback notifican estados, procesos en segundo plano, diálogos de confirmación y selección contextual.',
                      style: TextStyle(color: Color(0xFFB71C1C), fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 1. SnackBar
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'snack_bar'),
            interactiveDemo: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text('Operación completada con éxito'),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.grey.shade900,
                        duration: const Duration(seconds: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        action: SnackBarAction(
                          label: 'DESHACER',
                          textColor: Colors.amber,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Acción deshecha por el usuario'),
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.send_outlined),
                  label: const Text('Mostrar SnackBar Flotante'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // 2. Progress Indicators
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'progress_indicators'),
            controls: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    ChoiceChip(
                      avatar: const Icon(Icons.sync, size: 16),
                      label: const Text('Animación Continua'),
                      selected: _progressMode == _ProgressDisplayMode.continuous,
                      onSelected: (selected) {
                        if (selected) {
                          _stopSimulation();
                          setState(() => _progressMode = _ProgressDisplayMode.continuous);
                        }
                      },
                    ),
                    ChoiceChip(
                      avatar: const Icon(Icons.play_circle_outline, size: 16),
                      label: const Text('Simular Carga (0-100%)'),
                      selected: _progressMode == _ProgressDisplayMode.simulated,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _progressMode = _ProgressDisplayMode.simulated);
                          _startSimulation();
                        }
                      },
                    ),
                    ChoiceChip(
                      avatar: const Icon(Icons.tune, size: 16),
                      label: const Text('Control Manual'),
                      selected: _progressMode == _ProgressDisplayMode.manual,
                      onSelected: (selected) {
                        if (selected) {
                          _stopSimulation();
                          setState(() => _progressMode = _ProgressDisplayMode.manual);
                        }
                      },
                    ),
                  ],
                ),
                if (_progressMode == _ProgressDisplayMode.manual) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: _manualProgress,
                          min: 0.0,
                          max: 1.0,
                          activeColor: const Color(0xFFE53935),
                          onChanged: (v) => setState(() => _manualProgress = v),
                        ),
                      ),
                      Text(
                        '${(_manualProgress * 100).toInt()}%',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            interactiveDemo: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  // Estado actual o botón de reintento
                  if (_progressMode == _ProgressDisplayMode.continuous) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.autorenew, size: 16, color: Color(0xFFE53935)),
                          SizedBox(width: 6),
                          Text(
                            'Animación de carga en curso (modo indeterminado)',
                            style: TextStyle(
                              color: Color(0xFFE53935),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ] else if (_progressMode == _ProgressDisplayMode.simulated) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _isSimulating ? null : _startSimulation,
                          icon: Icon(_isSimulating ? Icons.hourglass_top : Icons.replay),
                          label: Text(_isSimulating ? 'Cargando datos...' : 'Reiniciar Animación'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE53935),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getSimulationMessage(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _simulatedProgress >= 1.0 ? Colors.green.shade800 : Colors.red.shade900,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Indicador Circular animado
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          value: _progressMode == _ProgressDisplayMode.continuous
                              ? null // Animación giratoria continua infinita
                              : _progressMode == _ProgressDisplayMode.simulated
                                  ? _simulatedProgress
                                  : _manualProgress,
                          color: const Color(0xFFE53935),
                          backgroundColor: Colors.red.shade100,
                          strokeWidth: 4.5,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CircularProgressIndicator',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _progressMode == _ProgressDisplayMode.continuous
                                ? 'Animación giratoria activa (value: null)'
                                : 'Progreso actual: ${((_progressMode == _ProgressDisplayMode.simulated ? _simulatedProgress : _manualProgress) * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Indicador Lineal animado
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'LinearProgressIndicator',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          if (_progressMode != _ProgressDisplayMode.continuous)
                            Text(
                              '${((_progressMode == _ProgressDisplayMode.simulated ? _simulatedProgress : _manualProgress) * 100).toInt()}%',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE53935)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: _progressMode == _ProgressDisplayMode.continuous
                              ? null // Animación de barrido horizontal continua
                              : _progressMode == _ProgressDisplayMode.simulated
                                  ? _simulatedProgress
                                  : _manualProgress,
                          color: const Color(0xFFE53935),
                          backgroundColor: Colors.red.shade100,
                          minHeight: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 3. AlertDialog
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'alert_dialog'),
            controls: Row(
              children: [
                FilterChip(
                  label: Text(_barrierDismissible ? 'Cerrable al tocar fuera: Sí' : 'Cerrable al tocar fuera: No'),
                  selected: _barrierDismissible,
                  onSelected: (v) => setState(() => _barrierDismissible = v),
                ),
              ],
            ),
            interactiveDemo: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final res = await showDialog<bool>(
                      context: context,
                      barrierDismissible: _barrierDismissible,
                      builder: (ctx) => AlertDialog(
                        title: const Row(
                          children: [
                            Icon(Icons.warning_amber_rounded, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Confirmación'),
                          ],
                        ),
                        content: const Text(
                          '¿Desea registrar y validar todos los widgets revisados en este laboratorio?',
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE53935),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Confirmar'),
                          ),
                        ],
                      ),
                    );

                    setState(() {
                      if (res == null) {
                        _dialogDecision = 'Cerrado tocando fuera del modal';
                      } else {
                        _dialogDecision = res ? 'Aceptado por el usuario' : 'Cancelado por el usuario';
                      }
                    });
                  },
                  icon: const Icon(Icons.open_in_browser),
                  label: const Text('Abrir Diálogo Modal showDialog()'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Última respuesta del diálogo: $_dialogDecision',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ],
            ),
          ),

          // 4. Chip & FilterChip
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'chip_filter_chip'),
            interactiveDemo: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'FilterChips de Selección Múltiple:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: ['Flutter', 'Dart', 'Android', 'Material 3', 'UNSAAC'].map((tech) {
                    final isSelected = _selectedChips.contains(tech);
                    return FilterChip(
                      label: Text(tech),
                      selected: isSelected,
                      selectedColor: Colors.red.shade100,
                      checkmarkColor: Colors.red.shade800,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedChips.add(tech);
                          } else {
                            _selectedChips.remove(tech);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Chips eliminables (onDeleted):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: _removableTags.map((tag) {
                    return Chip(
                      avatar: CircleAvatar(
                        backgroundColor: Colors.red.shade700,
                        child: Text(tag[0], style: const TextStyle(color: Colors.white, fontSize: 11)),
                      ),
                      label: Text(tag),
                      deleteIconColor: Colors.red.shade700,
                      onDeleted: () {
                        setState(() {
                          _removableTags.remove(tag);
                        });
                      },
                    );
                  }).toList(),
                ),
                if (_removableTags.isEmpty)
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _removableTags.addAll(['Widget', 'State', 'Context', 'Hot Reload']);
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Restaurar Chips'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
