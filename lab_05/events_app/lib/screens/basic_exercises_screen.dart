import 'dart:math';
import 'package:flutter/material.dart';
import '../services/event_bus.dart';
import '../models/event_log.dart';
import '../widgets/custom_app_bar.dart';

class BasicExercisesScreen extends StatefulWidget {
  final int initialTabIndex;
  const BasicExercisesScreen({super.key, this.initialTabIndex = 0});

  @override
  State<BasicExercisesScreen> createState() => _BasicExercisesScreenState();
}

class _BasicExercisesScreenState extends State<BasicExercisesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Estado Ejercicio 1: Color de fondo
  Color _backgroundColor = const Color(0xFF003366);
  final List<Color> _colorHistory = [];

  // Estado Ejercicio 2: Contador + y -
  int _counterValue = 0;
  int _counterStep = 1;

  // Estado Ejercicio 3: Captura de texto
  final TextEditingController _textCaptureController = TextEditingController();
  String _capturedText = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex.clamp(0, 2),
    );
    _colorHistory.add(_backgroundColor);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textCaptureController.dispose();
    super.dispose();
  }

  // --- MÉTODOS EJERCICIO 1 ---
  void _changeToRandomColor() {
    final random = Random();
    final newColor = Color.fromARGB(
      255,
      random.nextInt(220) + 20,
      random.nextInt(220) + 20,
      random.nextInt(220) + 20,
    );
    setState(() {
      _backgroundColor = newColor;
      _colorHistory.insert(0, newColor);
      if (_colorHistory.length > 6) {
        _colorHistory.removeLast();
      }
    });
    EventBus().emit(
      source: 'Ejercicio 1 (Básico)',
      type: EventType.tap,
      description: 'Cambio de color aleatorio -> HEX: #${newColor.value.toRadixString(16).toUpperCase()}',
    );
  }

  void _selectPresetColor(Color color, String name) {
    setState(() {
      _backgroundColor = color;
      _colorHistory.insert(0, color);
      if (_colorHistory.length > 6) {
        _colorHistory.removeLast();
      }
    });
    EventBus().emit(
      source: 'Ejercicio 1 (Básico)',
      type: EventType.tap,
      description: 'Seleccionado color predefinido: $name',
    );
  }

  // --- MÉTODOS EJERCICIO 2 ---
  void _increment() {
    setState(() {
      _counterValue += _counterStep;
    });
    EventBus().emit(
      source: 'Ejercicio 2 (Básico)',
      type: EventType.tap,
      description: 'Incrementar (+$_counterStep) -> Nuevo valor: $_counterValue',
    );
  }

  void _decrement() {
    setState(() {
      _counterValue -= _counterStep;
    });
    EventBus().emit(
      source: 'Ejercicio 2 (Básico)',
      type: EventType.tap,
      description: 'Decrementar (-$_counterStep) -> Nuevo valor: $_counterValue',
    );
  }

  void _resetCounter() {
    setState(() {
      _counterValue = 0;
    });
    EventBus().emit(
      source: 'Ejercicio 2 (Básico)',
      type: EventType.tap,
      description: 'Reinicio de contador a 0',
    );
  }

  // --- MÉTODOS EJERCICIO 3 ---
  bool _isPalindrome(String str) {
    final clean = str.toLowerCase().replaceAll(RegExp(r'[^a-záéíóúñ0-9]'), '');
    if (clean.length < 2) return false;
    return clean == clean.split('').reversed.join('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Ejercicios: Nivel Básico',
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.amber,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.palette), text: '1. Color Fondo'),
            Tab(icon: Icon(Icons.exposure), text: '2. Contador +/-'),
            Tab(icon: Icon(Icons.text_fields), text: '3. Captura Texto'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildExercise1(),
          _buildExercise2(),
          _buildExercise3(),
        ],
      ),
    );
  }

  // ===========================================================================
  // EJERCICIO 1: Botón que cambie el color de fondo
  // ===========================================================================
  Widget _buildExercise1() {
    final hexCode = '#${_backgroundColor.value.toRadixString(16).padLeft(8, '0').toUpperCase().substring(2)}';
    final isDarkBackground = ThemeData.estimateBrightnessForColor(_backgroundColor) == Brightness.dark;
    final textColor = isDarkBackground ? Colors.white : Colors.black87;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            height: 220,
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _backgroundColor.withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.format_paint, size: 48, color: textColor),
                  const SizedBox(height: 10),
                  Text(
                    'Color Activo: $hexCode',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'R: ${_backgroundColor.red} | G: ${_backgroundColor.green} | B: ${_backgroundColor.blue}',
                    style: TextStyle(color: textColor.withOpacity(0.85), fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _changeToRandomColor,
            icon: const Icon(Icons.shuffle),
            label: const Text('Generar Color Aleatorio (setState)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF003366),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Paleta de Colores Rápidos:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _colorChip(const Color(0xFF003366), 'Azul UNSAAC'),
              _colorChip(const Color(0xFF10B981), 'Esmeralda'),
              _colorChip(const Color(0xFF8B5CF6), 'Púrpura'),
              _colorChip(const Color(0xFFF59E0B), 'Ámbar'),
              _colorChip(const Color(0xFFEF4444), 'Carmín'),
              _colorChip(const Color(0xFF06B6D4), 'Cian'),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Historial de Colores Recientes:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _colorHistory.length,
              itemBuilder: (context, index) {
                final c = _colorHistory[index];
                return GestureDetector(
                  onTap: () => setState(() => _backgroundColor = c),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 48,
                    decoration: BoxDecoration(
                      color: c,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400, width: 2),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorChip(Color color, String name) {
    return ActionChip(
      avatar: CircleAvatar(backgroundColor: color, radius: 10),
      label: Text(name),
      onPressed: () => _selectPresetColor(color, name),
    );
  }

  // ===========================================================================
  // EJERCICIO 2: Contador con botones + y -
  // ===========================================================================
  Widget _buildExercise2() {
    Color displayColor;
    if (_counterValue > 0) {
      displayColor = Colors.green.shade700;
    } else if (_counterValue < 0) {
      displayColor = Colors.red.shade700;
    } else {
      displayColor = const Color(0xFF003366);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: displayColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: displayColor.withOpacity(0.3), width: 2),
            ),
            child: Column(
              children: [
                Text(
                  'VALOR ACTUAL',
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: displayColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$_counterValue',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: displayColor,
                  ),
                ),
                Text(
                  _counterValue > 0
                      ? 'Positivo'
                      : _counterValue < 0
                          ? 'Negativo'
                          : 'Neutro (Cero)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: displayColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove, size: 28),
                  label: Text('-$_counterStep', style: const TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _increment,
                  icon: const Icon(Icons.add, size: 28),
                  label: Text('+$_counterStep', style: const TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _resetCounter,
            icon: const Icon(Icons.restore),
            label: const Text('Reiniciar a Cero (Reset)'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Configurar Paso de Incremento / Decremento:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 1, label: Text('Paso ±1')),
              ButtonSegment(value: 5, label: Text('Paso ±5')),
              ButtonSegment(value: 10, label: Text('Paso ±10')),
            ],
            selected: {_counterStep},
            onSelectionChanged: (newSelection) {
              setState(() {
                _counterStep = newSelection.first;
              });
              EventBus().emit(
                source: 'Ejercicio 2 (Básico)',
                type: EventType.toggle,
                description: 'Paso modificado a ±$_counterStep',
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // EJERCICIO 3: Capturar texto y mostrarlo en pantalla
  // ===========================================================================
  Widget _buildExercise3() {
    final wordsCount = _capturedText.trim().isEmpty
        ? 0
        : _capturedText.trim().split(RegExp(r'\s+')).length;
    final isPal = _isPalindrome(_capturedText);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _textCaptureController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Ingrese texto a capturar en vivo',
              hintText: 'Ej. Flutter es genial para desarrollo móvil',
              prefixIcon: const Icon(Icons.text_format),
              suffixIcon: _capturedText.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _textCaptureController.clear();
                        setState(() {
                          _capturedText = '';
                        });
                        EventBus().emit(
                          source: 'Ejercicio 3 (Básico)',
                          type: EventType.changed,
                          description: 'Texto vaciado',
                        );
                      },
                    )
                  : null,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onChanged: (text) {
              setState(() {
                _capturedText = text;
              });
              EventBus().emit(
                source: 'Ejercicio 3 (Básico)',
                type: EventType.changed,
                description: 'Texto ingresado (${text.length} car.) -> "$text"',
              );
            },
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.visibility, color: Color(0xFF003366), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Vista Previa Dinámica',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      _capturedText.isEmpty
                          ? 'Esperando que ingrese algún texto...'
                          : _capturedText,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: _capturedText.isEmpty ? FontStyle.italic : FontStyle.normal,
                        color: _capturedText.isEmpty ? Colors.grey : Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Métricas Reactivas:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        avatar: const Icon(Icons.numbers, size: 16),
                        label: Text('Caracteres: ${_capturedText.length}'),
                      ),
                      Chip(
                        avatar: const Icon(Icons.spellcheck, size: 16),
                        label: Text('Palabras: $wordsCount'),
                      ),
                      if (isPal)
                        const Chip(
                          backgroundColor: Color(0xFFDCFCE7),
                          avatar: Icon(Icons.check_circle, size: 16, color: Colors.green),
                          label: Text('¡Es un Palíndromo!', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (_capturedText.isNotEmpty)
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            final reversed = _capturedText.split('').reversed.join('');
                            _textCaptureController.text = reversed;
                            setState(() {
                              _capturedText = reversed;
                            });
                            EventBus().emit(
                              source: 'Ejercicio 3 (Básico)',
                              type: EventType.tap,
                              description: 'Texto invertido en pantalla',
                            );
                          },
                          icon: const Icon(Icons.swap_horiz, size: 18),
                          label: const Text('Invertir'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
