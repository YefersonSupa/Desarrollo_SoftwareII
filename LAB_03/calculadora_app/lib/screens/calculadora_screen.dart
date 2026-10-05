import 'package:flutter/material.dart';
import '../models/calculator_logic.dart';

/// Ejercicio Propuesto: Calculadora Básica con Display Reactivo
/// - Muestra número actual y operación histórica
/// - Botones 0-9, ., +, -, ×, ÷, C, =, DEL, +/-, %
/// - Color dinámico en el display: Positivo (Azul), Negativo (Rojo), Cero (Gris)
/// - Organizado con StatefulWidget y distribución responsiva con Rows y Columns
class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  final CalculatorLogic _logic = CalculatorLogic();

  void _onDigitPressed(String digit) {
    setState(() {
      _logic.inputDigit(digit);
    });
  }

  void _onOperatorPressed(String op) {
    setState(() {
      _logic.setOperator(op);
    });
  }

  void _onCalculatePressed() {
    setState(() {
      _logic.calculate();
    });
  }

  void _onClearPressed() {
    setState(() {
      _logic.clear();
    });
  }

  void _onDeletePressed() {
    setState(() {
      _logic.deleteLast();
    });
  }

  void _onToggleSignPressed() {
    setState(() {
      _logic.toggleSign();
    });
  }

  void _onPercentagePressed() {
    setState(() {
      _logic.percentage();
    });
  }

  void _onDecimalPressed() {
    setState(() {
      _logic.inputDecimal();
    });
  }

  String _getEstadoTexto() {
    if (_logic.hasError) return 'Error';
    final val = _logic.numericValue;
    if (val > 0) return 'Positivo (Azul)';
    if (val < 0) return 'Negativo (Rojo)';
    return 'Cero (Gris)';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Flutter - Ejercicio Propuesto'),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Reglas de color del display',
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Reglas de Color del Display'),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Positivo (> 0): Azul'),
                      SizedBox(height: 6),
                      Text('• Negativo (< 0): Rojo'),
                      SizedBox(height: 6),
                      Text('• Cero (= 0): Gris'),
                      SizedBox(height: 12),
                      Text(
                        'Desarrollado para el laboratorio de Desarrollo de Aplicaciones Móviles (UNSAAC).',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Entendido'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF4F6F9),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              children: [
                // Sección de Display Numérico
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: _logic.displayColor.withValues(alpha: 0.4),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Historial y Badge de Estado
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: _logic.displayColor.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _getEstadoTexto(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _logic.displayColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                _logic.history,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Display principal con color dinámico
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            style: TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.bold,
                              color: _logic.displayColor,
                              letterSpacing: -1.0,
                            ),
                            child: Text(
                              _logic.currentInput,
                              key: const Key('display_text'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Sección del Teclado Numérico organizado con Columnas y Filas adaptables
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
                    child: Column(
                      children: [
                        // Fila 1: C, +/-, %, ÷
                        Expanded(
                          child: Row(
                            children: [
                              _buildGridButton(
                                text: 'C',
                                color: Colors.red.shade50,
                                textColor: Colors.red.shade700,
                                onPressed: _onClearPressed,
                              ),
                              _buildGridButton(
                                text: '+/-',
                                color: Colors.blueGrey.shade50,
                                textColor: Colors.blueGrey.shade800,
                                onPressed: _onToggleSignPressed,
                              ),
                              _buildGridButton(
                                text: '%',
                                color: Colors.blueGrey.shade50,
                                textColor: Colors.blueGrey.shade800,
                                onPressed: _onPercentagePressed,
                              ),
                              _buildGridButton(
                                text: '÷',
                                color: Colors.orange.shade500,
                                textColor: Colors.white,
                                onPressed: () => _onOperatorPressed('÷'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Fila 2: 7, 8, 9, ×
                        Expanded(
                          child: Row(
                            children: [
                              _buildGridButton(text: '7', onPressed: () => _onDigitPressed('7')),
                              _buildGridButton(text: '8', onPressed: () => _onDigitPressed('8')),
                              _buildGridButton(text: '9', onPressed: () => _onDigitPressed('9')),
                              _buildGridButton(
                                text: '×',
                                color: Colors.orange.shade500,
                                textColor: Colors.white,
                                onPressed: () => _onOperatorPressed('×'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Fila 3: 4, 5, 6, -
                        Expanded(
                          child: Row(
                            children: [
                              _buildGridButton(text: '4', onPressed: () => _onDigitPressed('4')),
                              _buildGridButton(text: '5', onPressed: () => _onDigitPressed('5')),
                              _buildGridButton(text: '6', onPressed: () => _onDigitPressed('6')),
                              _buildGridButton(
                                text: '-',
                                color: Colors.orange.shade500,
                                textColor: Colors.white,
                                onPressed: () => _onOperatorPressed('-'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Fila 4: 1, 2, 3, +
                        Expanded(
                          child: Row(
                            children: [
                              _buildGridButton(text: '1', onPressed: () => _onDigitPressed('1')),
                              _buildGridButton(text: '2', onPressed: () => _onDigitPressed('2')),
                              _buildGridButton(text: '3', onPressed: () => _onDigitPressed('3')),
                              _buildGridButton(
                                text: '+',
                                color: Colors.orange.shade500,
                                textColor: Colors.white,
                                onPressed: () => _onOperatorPressed('+'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Fila 5: DEL, 0, ., =
                        Expanded(
                          child: Row(
                            children: [
                              _buildGridButton(
                                icon: Icons.backspace_outlined,
                                color: Colors.grey.shade200,
                                textColor: Colors.grey.shade800,
                                onPressed: _onDeletePressed,
                              ),
                              _buildGridButton(text: '0', onPressed: () => _onDigitPressed('0')),
                              _buildGridButton(
                                text: '.',
                                onPressed: _onDecimalPressed,
                              ),
                              _buildGridButton(
                                text: '=',
                                color: Colors.blue.shade700,
                                textColor: Colors.white,
                                onPressed: _onCalculatePressed,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridButton({
    String? text,
    IconData? icon,
    Color? color,
    Color? textColor,
    required VoidCallback onPressed,
  }) {
    final bgColor = color ?? Colors.white;
    final fgColor = textColor ?? Colors.blueGrey.shade900;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Material(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.0),
          elevation: 2,
          shadowColor: Colors.black.withValues(alpha: 0.06),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(16.0),
            splashColor: fgColor.withValues(alpha: 0.15),
            highlightColor: fgColor.withValues(alpha: 0.05),
            child: Center(
              child: icon != null
                  ? Icon(icon, color: fgColor, size: 24)
                  : Text(
                      text ?? '',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: fgColor,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
