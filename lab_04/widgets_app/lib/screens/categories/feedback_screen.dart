import 'package:flutter/material.dart';
import '../../data/widgets_data.dart';
import '../../widgets/widget_demo_card.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  // Estados ProgressIndicator
  bool _isDeterminate = false;
  double _progressValue = 0.65;

  // Estados AlertDialog
  String _dialogDecision = 'Ninguna todavía';
  bool _barrierDismissible = true;

  // Estados Chip & FilterChip
  final Set<String> _selectedChips = {'Flutter', 'Dart'};
  final List<String> _removableTags = ['Widget', 'State', 'Context', 'Hot Reload'];

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
            controls: Row(
              children: [
                FilterChip(
                  label: Text(_isDeterminate ? 'Modo: Determinado (exacto)' : 'Modo: Indeterminado (animación)'),
                  selected: _isDeterminate,
                  onSelected: (v) => setState(() => _isDeterminate = v),
                ),
                if (_isDeterminate) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Slider(
                      value: _progressValue,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (v) => setState(() => _progressValue = v),
                    ),
                  ),
                  Text('${(_progressValue * 100).toInt()}%'),
                ],
              ],
            ),
            interactiveDemo: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularProgressIndicator(
                        value: _isDeterminate ? _progressValue : null,
                        color: const Color(0xFFE53935),
                        strokeWidth: 4,
                      ),
                      Text(
                        _isDeterminate
                            ? 'Progreso circular: ${(_progressValue * 100).toInt()}%'
                            : 'Cargando recursos...',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: _isDeterminate ? _progressValue : null,
                    color: const Color(0xFFE53935),
                    backgroundColor: Colors.red.shade100,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
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
