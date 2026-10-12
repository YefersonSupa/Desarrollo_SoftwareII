import 'package:flutter/material.dart';
import '../services/event_bus.dart';
import '../models/event_log.dart';
import '../widgets/custom_app_bar.dart';

class GuideExamplesScreen extends StatefulWidget {
  final int initialTabIndex;
  const GuideExamplesScreen({super.key, this.initialTabIndex = 0});

  @override
  State<GuideExamplesScreen> createState() => _GuideExamplesScreenState();
}

class _GuideExamplesScreenState extends State<GuideExamplesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Estado Ejemplo 1: Botón interactivo
  int _contadorEjemplo1 = 0;

  // Estado Ejemplo 2: Entrada de texto
  final TextEditingController _textControllerEjemplo2 = TextEditingController();
  String _textoCapturadoEjemplo2 = '';

  // Estado Ejemplo 3: Gestos
  String _ultimoGestoEjemplo3 = 'Ninguno';
  Color _colorCajaEjemplo3 = Colors.blue;
  int _gestoContadorEjemplo3 = 0;

  // Estado Mini Proyecto: Formulario
  String _nombreFormulario = '';
  final TextEditingController _formNombreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.initialTabIndex.clamp(0, 3),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textControllerEjemplo2.dispose();
    _formNombreController.dispose();
    super.dispose();
  }

  void _incrementarEjemplo1() {
    setState(() {
      _contadorEjemplo1++;
    });
    EventBus().emit(
      source: 'Ejemplo 1 (Guía)',
      type: EventType.tap,
      description: 'onPressed FloatingActionButton -> Contador: $_contadorEjemplo1',
    );
  }

  void _reiniciarEjemplo1() {
    setState(() {
      _contadorEjemplo1 = 0;
    });
    EventBus().emit(
      source: 'Ejemplo 1 (Guía)',
      type: EventType.tap,
      description: 'Reset contador a 0',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Ejemplos de la Guía Oficial',
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.amber,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.touch_app), text: 'Ej. 1: Botón'),
            Tab(icon: Icon(Icons.edit), text: 'Ej. 2: Texto'),
            Tab(icon: Icon(Icons.gesture), text: 'Ej. 3: Gestos'),
            Tab(icon: Icon(Icons.badge), text: 'Mini Proyecto'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEjemplo1(),
          _buildEjemplo2(),
          _buildEjemplo3(),
          _buildMiniProyecto(),
        ],
      ),
    );
  }

  // --- EJEMPLO 1 ---
  Widget _buildEjemplo1() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Card(
              color: Color(0xFFF0F9FF),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Guía: Sección 3 - Botón Interactivo\n'
                  'Uso de StatefulWidget, variable de estado "contador" y mutación mediante setState().',
                  style: TextStyle(color: Color(0xFF0369A1), fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.shade200, width: 2),
              ),
              child: Column(
                children: [
                  const Text('Valor del Contador:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text(
                    '$_contadorEjemplo1',
                    style: const TextStyle(
                      fontSize: 54,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _incrementarEjemplo1,
                  icon: const Icon(Icons.add),
                  label: const Text('Incrementar (onPressed)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003366),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _reiniciarEjemplo1,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reiniciar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- EJEMPLO 2 ---
  Widget _buildEjemplo2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Card(
            color: Color(0xFFF0FDF4),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Guía: Sección 4 - Entrada de Texto en Tiempo Real\n'
                'Captura de datos mediante TextField, TextEditingController y callback onChanged.',
                style: TextStyle(color: Color(0xFF15803D), fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _textControllerEjemplo2,
            decoration: InputDecoration(
              labelText: 'Escribe algo aquí...',
              hintText: 'Ej. Aprendiendo eventos en Flutter',
              prefixIcon: const Icon(Icons.keyboard),
              suffixIcon: _textoCapturadoEjemplo2.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _textControllerEjemplo2.clear();
                        setState(() {
                          _textoCapturadoEjemplo2 = '';
                        });
                        EventBus().emit(
                          source: 'Ejemplo 2 (Guía)',
                          type: EventType.changed,
                          description: 'Campo de texto limpiado',
                        );
                      },
                    )
                  : null,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (texto) {
              setState(() {
                _textoCapturadoEjemplo2 = texto;
              });
              EventBus().emit(
                source: 'Ejemplo 2 (Guía)',
                type: EventType.changed,
                description: 'onChanged -> "$texto" (${texto.length} caracteres)',
              );
            },
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Salida reactiva en tiempo real:',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Text(
                  _textoCapturadoEjemplo2.isEmpty
                      ? '(Esperando entrada del usuario...)'
                      : 'Texto capturado: "$_textoCapturadoEjemplo2"',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: _textoCapturadoEjemplo2.isEmpty ? Colors.grey : Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Chip(
                      label: Text('Longitud: ${_textoCapturadoEjemplo2.length}'),
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text('Palabras: ${_textoCapturadoEjemplo2.trim().isEmpty ? 0 : _textoCapturadoEjemplo2.trim().split(RegExp(r'\s+')).length}'),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- EJEMPLO 3 ---
  Widget _buildEjemplo3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Card(
            color: Color(0xFFFAF5FF),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Guía: Sección 5 - Manejo de Gestos Táctiles con GestureDetector\n'
                'Detecta onTap (toque), onDoubleTap (doble toque) y onLongPress (pulsación larga).',
                style: TextStyle(color: Color(0xFF7E22CE), fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                _ultimoGestoEjemplo3 = 'Tap detectado (Un solo toque)';
                _colorCajaEjemplo3 = Colors.blue;
                _gestoContadorEjemplo3++;
              });
              EventBus().emit(
                source: 'Ejemplo 3 (Guía)',
                type: EventType.tap,
                description: 'GestureDetector -> onTap',
              );
            },
            onDoubleTap: () {
              setState(() {
                _ultimoGestoEjemplo3 = 'Doble tap detectado (Dos toques)';
                _colorCajaEjemplo3 = Colors.purple;
                _gestoContadorEjemplo3 += 2;
              });
              EventBus().emit(
                source: 'Ejemplo 3 (Guía)',
                type: EventType.doubleTap,
                description: 'GestureDetector -> onDoubleTap',
              );
            },
            onLongPress: () {
              setState(() {
                _ultimoGestoEjemplo3 = 'Presión larga detectada (Long press)';
                _colorCajaEjemplo3 = Colors.deepOrange;
                _gestoContadorEjemplo3 += 5;
              });
              EventBus().emit(
                source: 'Ejemplo 3 (Guía)',
                type: EventType.longPress,
                description: 'GestureDetector -> onLongPress',
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: _colorCajaEjemplo3,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _colorCajaEjemplo3.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.touch_app, color: Colors.white, size: 48),
                    SizedBox(height: 8),
                    Text(
                      '¡Tócame!\nTap | Doble Tap | Long Press',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  'Último gesto: $_ultimoGestoEjemplo3',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text('Puntaje de interacción: $_gestoContadorEjemplo3 puntos'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- MINI PROYECTO ---
  Widget _buildMiniProyecto() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Card(
            color: Color(0xFFFEF3C7),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Guía: Sección 7 - Mini Proyecto: Formulario Interactivo\n'
                'Captura reactiva del nombre del usuario y generación en vivo del saludo "Hola, \$nombre".',
                style: TextStyle(color: Color(0xFFB45309), fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _formNombreController,
            decoration: InputDecoration(
              labelText: 'Ingrese su nombre',
              hintText: 'Ej. Yeferson',
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (value) {
              setState(() {
                _nombreFormulario = value;
              });
              EventBus().emit(
                source: 'Mini Proyecto (Guía)',
                type: EventType.changed,
                description: 'Nombre actualizado -> "$value"',
              );
            },
          ),
          const SizedBox(height: 30),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _nombreFormulario.trim().isEmpty
                    ? [Colors.blueGrey.shade400, Colors.blueGrey.shade600]
                    : [const Color(0xFF003366), const Color(0xFF1976D2)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const Icon(Icons.waving_hand, color: Colors.amber, size: 40),
                const SizedBox(height: 10),
                Text(
                  _nombreFormulario.trim().isEmpty
                      ? 'Hola, invitado'
                      : '¡Hola, $_nombreFormulario!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                const Text(
                  'Bienvenido a la Práctica 05 de Desarrollo de Software II',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
