import 'dart:async';
import 'package:flutter/material.dart';
import '../models/dynamic_item.dart';
import '../services/event_bus.dart';
import '../models/event_log.dart';
import '../widgets/custom_app_bar.dart';

class AdvancedExercisesScreen extends StatefulWidget {
  final int initialTabIndex;
  const AdvancedExercisesScreen({super.key, this.initialTabIndex = 0});

  @override
  State<AdvancedExercisesScreen> createState() => _AdvancedExercisesScreenState();
}

class _AdvancedExercisesScreenState extends State<AdvancedExercisesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ==================== ESTADO EJERCICIO 7: LISTA DINÁMICA ====================
  final List<DynamicItem> _dynamicList = [
    DynamicItem(
      id: '1',
      title: 'Repasar teoría de eventos en Flutter',
      category: 'Académico',
      priority: PriorityLevel.high,
      isCompleted: true,
    ),
    DynamicItem(
      id: '2',
      title: 'Implementar validación con GlobalKey<FormState>',
      category: 'Proyecto',
      priority: PriorityLevel.high,
      isCompleted: false,
    ),
    DynamicItem(
      id: '3',
      title: 'Crear suite de pruebas unitarias',
      category: 'Proyecto',
      priority: PriorityLevel.medium,
      isCompleted: false,
    ),
  ];
  final TextEditingController _itemTitleController = TextEditingController();
  PriorityLevel _selectedPriority = PriorityLevel.medium;
  final String _selectedCategory = 'Proyecto';

  // ==================== ESTADO EJERCICIO 8: VALIDACIÓN FORM ===================
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _formFullNameController = TextEditingController();
  final TextEditingController _formEmailController = TextEditingController();
  final TextEditingController _formStudentCodeController = TextEditingController();
  final TextEditingController _formPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _acceptTerms = false;
  bool _formSubmittedSuccess = false;

  // ==================== ESTADO EJERCICIO 9: JUEGO TAPS ========================
  int _gameTapsCount = 0;
  int _gameTimeRemaining = 10;
  Timer? _gameTimer;
  bool _isGameRunning = false;
  bool _isGameOver = false;
  int _gameHighScore = 0;
  double _buttonScale = 1.0;

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
    _itemTitleController.dispose();
    _formFullNameController.dispose();
    _formEmailController.dispose();
    _formStudentCodeController.dispose();
    _formPasswordController.dispose();
    _gameTimer?.cancel();
    super.dispose();
  }

  // --- MÉTODOS EJERCICIO 7 ---
  void _addNewItem() {
    final title = _itemTitleController.text.trim();
    if (title.isEmpty) return;

    final newItem = DynamicItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      category: _selectedCategory,
      priority: _selectedPriority,
    );

    setState(() {
      _dynamicList.insert(0, newItem);
      _itemTitleController.clear();
    });

    EventBus().emit(
      source: 'Ejercicio 7 (Avanzado)',
      type: EventType.submitted,
      description: 'Elemento agregado a la lista: "$title" [${newItem.priorityText}]',
    );
  }

  void _toggleItemStatus(DynamicItem item) {
    setState(() {
      item.isCompleted = !item.isCompleted;
    });
    EventBus().emit(
      source: 'Ejercicio 7 (Avanzado)',
      type: EventType.toggle,
      description: 'Ítem "${item.title}" marcado como ${item.isCompleted ? "Completado" : "Pendiente"}',
    );
  }

  void _deleteItem(DynamicItem item) {
    final index = _dynamicList.indexOf(item);
    setState(() {
      _dynamicList.remove(item);
    });

    EventBus().emit(
      source: 'Ejercicio 7 (Avanzado)',
      type: EventType.drag,
      description: 'Ítem eliminado de la lista: "${item.title}"',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Se eliminó "${item.title}"'),
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () {
            setState(() {
              _dynamicList.insert(index, item);
            });
            EventBus().emit(
              source: 'Ejercicio 7 (Avanzado)',
              type: EventType.tap,
              description: 'Eliminación deshecha para "${item.title}"',
            );
          },
        ),
      ),
    );
  }

  // --- MÉTODOS EJERCICIO 8 ---
  void _submitForm() {
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debe aceptar los términos y condiciones para continuar.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _formSubmittedSuccess = true;
      });

      EventBus().emit(
        source: 'Ejercicio 8 (Avanzado)',
        type: EventType.submitted,
        description: 'Formulario validado con éxito para: ${_formFullNameController.text}',
      );

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          icon: const Icon(Icons.check_circle, color: Colors.green, size: 50),
          title: const Text('¡Validación Exitosa!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Todos los campos cumplen con los criterios de validación:'),
              const SizedBox(height: 12),
              Text('• Nombre: ${_formFullNameController.text}'),
              Text('• Correo: ${_formEmailController.text}'),
              Text('• Código: ${_formStudentCodeController.text}'),
              const Text('• Contraseña: [Cifrada y Segura]'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );
    }
  }

  // --- MÉTODOS EJERCICIO 9: JUEGO TAPS ---
  void _startGame() {
    _gameTimer?.cancel();
    setState(() {
      _gameTapsCount = 0;
      _gameTimeRemaining = 10;
      _isGameRunning = true;
      _isGameOver = false;
    });

    EventBus().emit(
      source: 'Ejercicio 9 (Avanzado)',
      type: EventType.tap,
      description: 'Juego de Taps iniciado (10 segundos)',
    );

    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_gameTimeRemaining > 1) {
        setState(() {
          _gameTimeRemaining--;
        });
      } else {
        timer.cancel();
        _endGame();
      }
    });
  }

  void _onGameTap() {
    if (!_isGameRunning) return;

    setState(() {
      _gameTapsCount++;
      _buttonScale = 0.92;
    });

    Future.delayed(const Duration(milliseconds: 60), () {
      if (mounted) {
        setState(() {
          _buttonScale = 1.0;
        });
      }
    });

    EventBus().emit(
      source: 'Ejercicio 9 (Avanzado)',
      type: EventType.tap,
      description: 'Tap en juego -> Contador: $_gameTapsCount',
    );
  }

  void _endGame() {
    setState(() {
      _isGameRunning = false;
      _isGameOver = true;
      _gameTimeRemaining = 0;
      if (_gameTapsCount > _gameHighScore) {
        _gameHighScore = _gameTapsCount;
      }
    });

    EventBus().emit(
      source: 'Ejercicio 9 (Avanzado)',
      type: EventType.system,
      description: 'Fin del juego -> Score: $_gameTapsCount taps (Record: $_gameHighScore)',
    );
  }

  String _getGameRank(int taps) {
    if (taps >= 70) return '🏆 Maestro Supremo de los Taps';
    if (taps >= 50) return '⚡ Dedos Supersónicos';
    if (taps >= 35) return '🔥 Jugador Ágil';
    if (taps >= 20) return '👍 Buen Ritmo';
    return '🐢 Principiante';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Ejercicios: Nivel Avanzado',
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.amber,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.format_list_bulleted), text: '7. Lista Dinámica'),
            Tab(icon: Icon(Icons.rule_folder), text: '8. Validación'),
            Tab(icon: Icon(Icons.videogame_asset), text: '9. Juego Taps'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildExercise7(),
          _buildExercise8(),
          _buildExercise9(),
        ],
      ),
    );
  }

  // ===========================================================================
  // EJERCICIO 7: Lista dinámica reactiva
  // ===========================================================================
  Widget _buildExercise7() {
    final completedCount = _dynamicList.where((i) => i.isCompleted).length;
    final pendingCount = _dynamicList.length - completedCount;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.blue.shade50,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _itemTitleController,
                      decoration: InputDecoration(
                        hintText: 'Nueva tarea o elemento...',
                        prefixIcon: const Icon(Icons.add_task),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onSubmitted: (_) => _addNewItem(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _addNewItem,
                    icon: const Icon(Icons.add),
                    style: IconButton.styleFrom(backgroundColor: const Color(0xFF003366)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<PriorityLevel>(
                    value: _selectedPriority,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(value: PriorityLevel.low, child: Text('Prioridad Baja')),
                      DropdownMenuItem(value: PriorityLevel.medium, child: Text('Prioridad Media')),
                      DropdownMenuItem(value: PriorityLevel.high, child: Text('Prioridad Alta')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedPriority = val);
                    },
                  ),
                  Row(
                    children: [
                      Chip(
                        avatar: const Icon(Icons.pending_actions, size: 14),
                        label: Text('Pendientes: $pendingCount'),
                        visualDensity: VisualDensity.compact,
                      ),
                      const SizedBox(width: 6),
                      Chip(
                        avatar: const Icon(Icons.task_alt, size: 14, color: Colors.green),
                        label: Text('Listas: $completedCount'),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: _dynamicList.isEmpty
              ? const Center(
                  child: Text(
                    'No hay elementos en la lista.\nAgrega uno arriba.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _dynamicList.length,
                  itemBuilder: (context, index) {
                    final item = _dynamicList[index];
                    return Dismissible(
                      key: Key(item.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.redAccent,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) => _deleteItem(item),
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                        elevation: 1.5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: Checkbox(
                            value: item.isCompleted,
                            activeColor: const Color(0xFF003366),
                            onChanged: (_) => _toggleItemStatus(item),
                          ),
                          title: Text(
                            item.title,
                            style: TextStyle(
                              decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                              color: item.isCompleted ? Colors.grey : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text('Categoría: ${item.category}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: item.priorityColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  item.priorityText,
                                  style: TextStyle(
                                    color: item.priorityColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.grey, size: 20),
                                onPressed: () => _deleteItem(item),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // ===========================================================================
  // EJERCICIO 8: Validación de Formulario (Form & GlobalKey<FormState>)
  // ===========================================================================
  Widget _buildExercise8() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Formulario Institucional con Validadores en Tiempo Real:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _formFullNameController,
              decoration: InputDecoration(
                labelText: 'Nombre y Apellidos *',
                hintText: 'Ej. Juan Pérez Quispe',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'El nombre es obligatorio';
                }
                if (value.trim().length < 3) {
                  return 'Debe contener al menos 3 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _formEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico *',
                hintText: 'ejemplo@unsaac.edu.pe',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'El correo es obligatorio';
                }
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value.trim())) {
                  return 'Ingrese un formato de correo válido (ej. usuario@dominio.com)';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _formStudentCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Código de Estudiante / DNI (6-8 dígitos) *',
                hintText: '220553',
                prefixIcon: const Icon(Icons.badge),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'El código es obligatorio';
                }
                if (!RegExp(r'^\d{6,8}$').hasMatch(value.trim())) {
                  return 'Debe ser numérico de 6 a 8 dígitos exactos';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _formPasswordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Contraseña de Seguridad *',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La contraseña es obligatoria';
                }
                if (value.length < 6) {
                  return 'Mínimo 6 caracteres requeridos';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Acepto los términos y políticas académicas', style: TextStyle(fontSize: 13)),
              value: _acceptTerms,
              onChanged: (val) {
                setState(() {
                  _acceptTerms = val ?? false;
                });
              },
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.send),
              label: const Text('Validar y Enviar Formulario'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003366),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            if (_formSubmittedSuccess) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '¡Formulario verificado! Todos los inputs pasaron la validación reactiva.',
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // EJERCICIO 9: Juego Simple - Contador de Taps (Speed Tap Rush)
  // ===========================================================================
  Widget _buildExercise9() {
    final tps = _isGameRunning
        ? (_gameTapsCount / (10 - _gameTimeRemaining + 0.001)).toStringAsFixed(1)
        : (_gameTapsCount / 10.0).toStringAsFixed(1);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade400),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.emoji_events, color: Colors.amber, size: 22),
                    const SizedBox(width: 6),
                    Text(
                      'Récord: $_gameHighScore',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: _gameTimeRemaining <= 3 ? Colors.red.shade100 : Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _gameTimeRemaining <= 3 ? Colors.red : Colors.blue,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer,
                      color: _gameTimeRemaining <= 3 ? Colors.red : Colors.blue,
                      size: 22,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$_gameTimeRemaining s',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: _gameTimeRemaining <= 3 ? Colors.red : Colors.blue.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: _isGameRunning ? _onGameTap : null,
              child: AnimatedScale(
                scale: _buttonScale,
                duration: const Duration(milliseconds: 60),
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: _isGameRunning
                          ? [const Color(0xFFFF5252), const Color(0xFFD50000)]
                          : [Colors.grey.shade400, Colors.grey.shade600],
                      stops: const [0.4, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _isGameRunning
                            ? Colors.red.withOpacity(0.5)
                            : Colors.black.withOpacity(0.15),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isGameRunning ? Icons.touch_app : Icons.play_arrow,
                          size: 60,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _isGameRunning ? '¡TAP RÁPIDO!' : 'Presiona Iniciar',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$_gameTapsCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (!_isGameRunning)
            ElevatedButton.icon(
              onPressed: _startGame,
              icon: const Icon(Icons.play_arrow),
              label: Text(_isGameOver ? 'Jugar Otra Vez' : 'Comenzar Reto (10 Segundos)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003366),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          if (_isGameOver) ...[
            const SizedBox(height: 20),
            Card(
              color: const Color(0xFFF8FAFC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.blue.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    const Text(
                      '¡RESULTADOS DE LA PARTIDA!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF003366)),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _getGameRank(_gameTapsCount),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Taps Totales: $_gameTapsCount'),
                        Text('Velocidad: $tps taps/seg'),
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
}
