import 'dart:async';
import 'package:flutter/material.dart';
import '../services/event_bus.dart';
import '../models/event_log.dart';
import '../widgets/custom_app_bar.dart';

class IntermediateExercisesScreen extends StatefulWidget {
  final int initialTabIndex;
  const IntermediateExercisesScreen({super.key, this.initialTabIndex = 0});

  @override
  State<IntermediateExercisesScreen> createState() => _IntermediateExercisesScreenState();
}

class _IntermediateExercisesScreenState extends State<IntermediateExercisesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Estado Ejercicio 4: Nombre y edad
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _profileName = '';
  int? _profileAge;

  // Estado Ejercicio 5: Switch de encendido/apagado
  bool _isSwitchOn = false;
  double _brightnessLevel = 0.8;
  Color _lightBulbColor = Colors.amber;

  // Estado Ejercicio 6: Detección de doble clic
  int _doubleTapCount = 0;
  bool _showHeartAnimation = false;
  String _lastGestureMessage = 'Da doble clic en la tarjeta';
  DateTime? _lastTapTime;
  Timer? _heartTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex.clamp(0, 2),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _heartTimer?.cancel();
    super.dispose();
  }

  // --- MÉTODOS EJERCICIO 4 ---
  String _getAgeGroup(int age) {
    if (age < 0) return 'Edad no válida';
    if (age <= 11) return 'Infancia / Niñez';
    if (age <= 17) return 'Adolescencia';
    if (age <= 29) return 'Juventud';
    if (age <= 59) return 'Adultez';
    return 'Persona Mayor / Tercera Edad';
  }

  // --- MÉTODOS EJERCICIO 6 ---
  void _triggerDoubleTap() {
    setState(() {
      _doubleTapCount++;
      _showHeartAnimation = true;
      _lastGestureMessage = '¡Doble clic detectado! (Likes: $_doubleTapCount)';
      _lastTapTime = DateTime.now();
    });

    EventBus().emit(
      source: 'Ejercicio 6 (Intermedio)',
      type: EventType.doubleTap,
      description: 'onDoubleTap detectado exitosamente (Total: $_doubleTapCount)',
    );

    _heartTimer?.cancel();
    _heartTimer = Timer(const Duration(milliseconds: 900), () {
      if (mounted) {
        setState(() {
          _showHeartAnimation = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Ejercicios: Nivel Intermedio',
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.amber,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.person_pin), text: '4. Nombre y Edad'),
            Tab(icon: Icon(Icons.lightbulb), text: '5. Switch On/Off'),
            Tab(icon: Icon(Icons.favorite), text: '6. Doble Clic'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildExercise4(),
          _buildExercise5(),
          _buildExercise6(),
        ],
      ),
    );
  }

  // ===========================================================================
  // EJERCICIO 4: Formulario con nombre y edad
  // ===========================================================================
  Widget _buildExercise4() {
    final hasValidData = _profileName.trim().isNotEmpty && _profileAge != null && _profileAge! >= 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Ingrese los datos para generar el perfil dinámico:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nombre Completo',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (val) {
              setState(() {
                _profileName = val;
              });
              EventBus().emit(
                source: 'Ejercicio 4 (Intermedio)',
                type: EventType.changed,
                description: 'Nombre cambiado -> "$val"',
              );
            },
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Edad (años)',
              prefixIcon: const Icon(Icons.calendar_today_outlined),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (val) {
              setState(() {
                _profileAge = int.tryParse(val);
              });
              EventBus().emit(
                source: 'Ejercicio 4 (Intermedio)',
                type: EventType.changed,
                description: 'Edad cambiada -> "$val"',
              );
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Credencial / Perfil Generado en Tiempo Real:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 12),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: hasValidData
                    ? [const Color(0xFF0F172A), const Color(0xFF1E3A8A)]
                    : [Colors.grey.shade400, Colors.grey.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'UNSAAC • DSI II',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Icon(
                      hasValidData ? Icons.verified : Icons.help_outline,
                      color: hasValidData ? Colors.greenAccent : Colors.white70,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white24,
                      child: Text(
                        _profileName.trim().isNotEmpty
                            ? _profileName.trim().substring(0, 1).toUpperCase()
                            : '?',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _profileName.trim().isEmpty ? 'Nombre pendiente' : _profileName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _profileAge != null
                                ? '$_profileAge años • ${_getAgeGroup(_profileAge!)}'
                                : 'Edad sin definir',
                            style: const TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Estado de validación:',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                      Text(
                        hasValidData ? 'Datos válidos y sincronizados' : 'Esperando datos completos',
                        style: TextStyle(
                          color: hasValidData ? Colors.lightGreenAccent : Colors.white60,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // EJERCICIO 5: Implementar un switch (encendido/apagado)
  // ===========================================================================
  Widget _buildExercise5() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _isSwitchOn ? const Color(0xFF1E293B) : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: _isSwitchOn ? _lightBulbColor.withOpacity(0.8) : Colors.grey.shade400,
                width: 2,
              ),
              boxShadow: _isSwitchOn
                  ? [
                      BoxShadow(
                        color: _lightBulbColor.withOpacity(0.35 * _brightnessLevel),
                        blurRadius: 30 * _brightnessLevel + 10,
                        spreadRadius: 6 * _brightnessLevel,
                      ),
                    ]
                  : [],
            ),
            child: Column(
              children: [
                Icon(
                  _isSwitchOn ? Icons.lightbulb : Icons.lightbulb_outline,
                  size: 90,
                  color: _isSwitchOn
                      ? _lightBulbColor.withOpacity(0.4 + 0.6 * _brightnessLevel)
                      : Colors.grey.shade500,
                ),
                const SizedBox(height: 12),
                Text(
                  _isSwitchOn ? 'ESTADO: ENCENDIDO (ON)' : 'ESTADO: APAGADO (OFF)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: _isSwitchOn ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _isSwitchOn
                      ? 'Consumo estimado: ${(60 * _brightnessLevel).toStringAsFixed(1)} W'
                      : 'Consumo: 0.0 W (Ahorro de energía)',
                  style: TextStyle(
                    fontSize: 13,
                    color: _isSwitchOn ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SwitchListTile(
                title: const Text('Interruptor Principal', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(_isSwitchOn ? 'Energía activada' : 'Circuito abierto'),
                value: _isSwitchOn,
                activeColor: Colors.amber,
                onChanged: (bool val) {
                  setState(() {
                    _isSwitchOn = val;
                  });
                  EventBus().emit(
                    source: 'Ejercicio 5 (Intermedio)',
                    type: EventType.toggle,
                    description: 'Switch alternado a -> ${val ? "ENCENDIDO" : "APAGADO"}',
                  );
                },
              ),
            ),
          ),
          if (_isSwitchOn) ...[
            const SizedBox(height: 18),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Intensidad de Brillo:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${(_brightnessLevel * 100).toInt()}%'),
                      ],
                    ),
                    Slider(
                      value: _brightnessLevel,
                      min: 0.1,
                      max: 1.0,
                      divisions: 9,
                      activeColor: _lightBulbColor,
                      label: '${(_brightnessLevel * 100).toInt()}%',
                      onChanged: (newVal) {
                        setState(() {
                          _brightnessLevel = newVal;
                        });
                        EventBus().emit(
                          source: 'Ejercicio 5 (Intermedio)',
                          type: EventType.drag,
                          description: 'Brillo ajustado a -> ${(_brightnessLevel * 100).toInt()}%',
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const Text('Tonalidad de la Luz:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _bulbColorChoice(Colors.amber, 'Cálido'),
                        _bulbColorChoice(Colors.lightBlueAccent, 'Frío'),
                        _bulbColorChoice(Colors.greenAccent, 'Neón'),
                        _bulbColorChoice(Colors.purpleAccent, 'Púrpura'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _bulbColorChoice(Color c, String label) {
    return ChoiceChip(
      selected: _lightBulbColor == c,
      label: Text(label),
      avatar: CircleAvatar(backgroundColor: c, radius: 8),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _lightBulbColor = c;
          });
        }
      },
    );
  }

  // ===========================================================================
  // EJERCICIO 6: Detectar doble clic en un contenedor
  // ===========================================================================
  Widget _buildExercise6() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Demostración de Doble Clic (GestureDetector onDoubleTap):',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 6),
          const Text(
            'Toca dos veces rápidamente dentro del contenedor para enviar un "Me gusta" interactivo estilo red social.',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 18),
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _lastGestureMessage = 'Detectado un solo clic (Tap simple)';
                });
                EventBus().emit(
                  source: 'Ejercicio 6 (Intermedio)',
                  type: EventType.tap,
                  description: 'onTap simple en el contenedor interactivo',
                );
              },
              onDoubleTap: _triggerDoubleTap,
              onLongPress: () {
                setState(() {
                  _lastGestureMessage = 'Detectada pulsación larga (Long press)';
                });
                EventBus().emit(
                  source: 'Ejercicio 6 (Intermedio)',
                  type: EventType.longPress,
                  description: 'onLongPress en el contenedor interactivo',
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF833AB4), Color(0xFFFD1D1D), Color(0xFFFCB045)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.touch_app, color: Colors.white, size: 60),
                        const SizedBox(height: 12),
                        const Text(
                          '¡DOBLE CLIC AQUÍ!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Likes acumulados: $_doubleTapCount',
                          style: const TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  if (_showHeartAnimation)
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.2, end: 1.4),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: Icon(
                            Icons.favorite,
                            size: 110,
                            color: Colors.white.withOpacity(0.95),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    _lastGestureMessage,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  if (_lastTapTime != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Último registro: ${_lastTapTime!.hour.toString().padLeft(2, '0')}:${_lastTapTime!.minute.toString().padLeft(2, '0')}:${_lastTapTime!.second.toString().padLeft(2, '0')}.${_lastTapTime!.millisecond}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        _doubleTapCount = 0;
                        _lastGestureMessage = 'Contador de dobles clics reiniciado';
                      });
                      EventBus().emit(
                        source: 'Ejercicio 6 (Intermedio)',
                        type: EventType.tap,
                        description: 'Likes reiniciados a 0',
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reiniciar Contador de Likes'),
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
