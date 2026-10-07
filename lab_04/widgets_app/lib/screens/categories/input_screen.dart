import 'package:flutter/material.dart';
import '../../data/widgets_data.dart';
import '../../widgets/widget_demo_card.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  // Estados ElevatedButton
  bool _isButtonEnabled = true;
  int _buttonClickCount = 0;

  // Estados TextField
  final TextEditingController _textController = TextEditingController(text: 'yeferson@unsaac.edu.pe');
  String _typedText = 'yeferson@unsaac.edu.pe';
  bool _obscureText = false;

  // Estados Switch & Checkbox
  bool _switchVal = true;
  bool _checkboxVal = true;

  // Estados DropdownButton
  String _selectedOption = 'Opción A: Material 3';
  final List<String> _dropdownOptions = [
    'Opción A: Material 3',
    'Opción B: Flutter 3.47',
    'Opción C: Dart 3.13',
    'Opción D: UNSAAC 2026',
  ];

  // Estados Slider
  double _sliderVal = 50.0;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widgets = kWidgetsList.where((w) => w.category.name == 'input').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets de Input (5)'),
        backgroundColor: const Color(0xFFFB8C00),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: const Color(0xFFFFF3E0),
            margin: const EdgeInsets.only(bottom: 16),
            child: const Padding(
              padding: EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(Icons.input, color: Color(0xFFFB8C00), size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Los widgets de Input capturan datos, eventos y selecciones activas del usuario para procesar interacciones.',
                      style: TextStyle(color: Color(0xFFE65100), fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 1. ElevatedButton
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'elevated_button'),
            controls: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Estado del botón: ${_isButtonEnabled ? "Habilitado" : "Deshabilitado"}'),
                Switch(
                  value: _isButtonEnabled,
                  onChanged: (v) => setState(() => _isButtonEnabled = v),
                ),
              ],
            ),
            interactiveDemo: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: _isButtonEnabled
                      ? () {
                          setState(() {
                            _buttonClickCount++;
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFB8C00),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.touch_app),
                  label: const Text('Pulsar Botón', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 8),
                Text(
                  _isButtonEnabled
                      ? 'Pulsado: $_buttonClickCount veces'
                      : '(Botón deshabilitado porque onPressed = null)',
                  style: TextStyle(
                    color: _isButtonEnabled ? Colors.black87 : Colors.grey,
                    fontStyle: _isButtonEnabled ? FontStyle.normal : FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // 2. TextField
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'text_field'),
            controls: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterChip(
                  label: Text(_obscureText ? 'Contraseña: Oculta' : 'Texto: Visible'),
                  selected: _obscureText,
                  onSelected: (v) => setState(() => _obscureText = v),
                ),
                TextButton.icon(
                  onPressed: () {
                    _textController.clear();
                    setState(() => _typedText = '');
                  },
                  icon: const Icon(Icons.clear, size: 16),
                  label: const Text('Limpiar'),
                ),
              ],
            ),
            interactiveDemo: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _textController,
                  obscureText: _obscureText,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Correo Institucional UNSAAC',
                    hintText: 'ejemplo@unsaac.edu.pe',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email_outlined),
                    suffixIcon: _typedText.contains('@')
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.error_outline, color: Colors.orange),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _typedText = val;
                    });
                  },
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Valor en tiempo real: "$_typedText"',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

          // 3. Switch & Checkbox
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'switch_checkbox'),
            interactiveDemo: Column(
              children: [
                SwitchListTile(
                  title: const Text('Notificaciones push de la app'),
                  subtitle: Text(_switchVal ? 'Activadas' : 'Desactivadas'),
                  value: _switchVal,
                  activeColor: const Color(0xFFFB8C00),
                  onChanged: (val) => setState(() => _switchVal = val),
                ),
                CheckboxListTile(
                  title: const Text('Acepto términos y políticas de laboratorio'),
                  subtitle: Text(_checkboxVal ? 'Consentimiento verificado' : 'Pendiente de aceptación'),
                  value: _checkboxVal,
                  activeColor: const Color(0xFFFB8C00),
                  onChanged: (val) => setState(() => _checkboxVal = val ?? false),
                ),
              ],
            ),
          ),

          // 4. DropdownButton
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'dropdown_button'),
            interactiveDemo: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedOption,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: _dropdownOptions.map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e, style: const TextStyle(fontWeight: FontWeight.w500)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedOption = val);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Elemento seleccionado: $_selectedOption',
                  style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // 5. Slider
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'slider'),
            interactiveDemo: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nivel de volumen o ajuste:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Chip(
                      label: Text('${_sliderVal.round()}%'),
                      backgroundColor: Colors.orange.shade100,
                    ),
                  ],
                ),
                Slider(
                  value: _sliderVal,
                  min: 0.0,
                  max: 100.0,
                  divisions: 10,
                  label: '${_sliderVal.round()}%',
                  activeColor: const Color(0xFFFB8C00),
                  onChanged: (val) => setState(() => _sliderVal = val),
                ),
                LinearProgressIndicator(
                  value: _sliderVal / 100.0,
                  backgroundColor: Colors.orange.shade100,
                  color: const Color(0xFFFB8C00),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
