import 'package:flutter/material.dart';

/// Lógica de negocio desacoplada para la calculadora básica.
/// Permite pruebas unitarias puras y reutilización en cualquier interfaz Flutter.
class CalculatorLogic {
  String _currentInput = '0';
  String _history = '';
  double? _firstOperand;
  String? _operator;
  bool _shouldResetInput = false;
  bool _hasError = false;

  String get currentInput => _currentInput;
  String get history => _history;
  bool get hasError => _hasError;

  /// Obtiene el valor numérico actual para evaluar el color del display.
  double get numericValue {
    if (_hasError) return 0.0;
    return double.tryParse(_currentInput) ?? 0.0;
  }

  /// Retorna el color correspondiente al display según el valor del resultado:
  /// - Positivo: Azul
  /// - Negativo: Rojo
  /// - Cero: Gris
  Color get displayColor {
    if (_hasError) {
      return Colors.red.shade700;
    }
    final val = numericValue;
    if (val > 0) {
      return Colors.blue.shade700;
    } else if (val < 0) {
      return Colors.red.shade700;
    } else {
      return Colors.grey.shade600;
    }
  }

  /// Ingresa un dígito (0 - 9)
  void inputDigit(String digit) {
    if (_hasError) {
      clear();
    }

    if (_shouldResetInput || _currentInput == '0') {
      _currentInput = digit;
      _shouldResetInput = false;
    } else {
      // Limitar a un máximo de 12 dígitos para evitar desbordes visuales
      if (_currentInput.length < 12) {
        _currentInput += digit;
      }
    }
  }

  /// Ingresa el punto decimal (.)
  void inputDecimal() {
    if (_hasError) {
      clear();
    }

    if (_shouldResetInput) {
      _currentInput = '0.';
      _shouldResetInput = false;
    } else if (!_currentInput.contains('.')) {
      _currentInput += '.';
    }
  }

  /// Establece el operador (+, -, ×, ÷)
  void setOperator(String op) {
    if (_hasError) return;

    final currentVal = double.tryParse(_currentInput);
    if (currentVal == null) return;

    if (_firstOperand != null && _operator != null && !_shouldResetInput) {
      calculate();
    }

    _firstOperand = double.tryParse(_currentInput);
    _operator = op;
    _history = '${_formatNumber(_firstOperand!)} $op';
    _shouldResetInput = true;
  }

  /// Ejecuta el cálculo al presionar el botón '='
  void calculate() {
    if (_operator == null || _firstOperand == null || _hasError) return;

    final secondOperand = double.tryParse(_currentInput);
    if (secondOperand == null) return;

    double result = 0.0;
    switch (_operator) {
      case '+':
        result = _firstOperand! + secondOperand;
        break;
      case '-':
        result = _firstOperand! - secondOperand;
        break;
      case '×':
      case '*':
        result = _firstOperand! * secondOperand;
        break;
      case '÷':
      case '/':
        if (secondOperand == 0) {
          _currentInput = 'Error';
          _hasError = true;
          _history = '${_formatNumber(_firstOperand!)} $_operator 0 =';
          _firstOperand = null;
          _operator = null;
          _shouldResetInput = true;
          return;
        }
        result = _firstOperand! / secondOperand;
        break;
      default:
        return;
    }

    _history = '${_formatNumber(_firstOperand!)} $_operator ${_formatNumber(secondOperand)} =';
    _currentInput = _formatNumber(result);
    _firstOperand = result;
    _operator = null;
    _shouldResetInput = true;
  }

  /// Limpia todo el estado de la calculadora (Botón C)
  void clear() {
    _currentInput = '0';
    _history = '';
    _firstOperand = null;
    _operator = null;
    _shouldResetInput = false;
    _hasError = false;
  }

  /// Borra el último dígito ingresado (DEL)
  void deleteLast() {
    if (_hasError || _shouldResetInput) {
      clear();
      return;
    }

    if (_currentInput.length > 1) {
      _currentInput = _currentInput.substring(0, _currentInput.length - 1);
      if (_currentInput == '-') {
        _currentInput = '0';
      }
    } else {
      _currentInput = '0';
    }
  }

  /// Alterna el signo (+/-)
  void toggleSign() {
    if (_hasError || _currentInput == '0') return;

    if (_currentInput.startsWith('-')) {
      _currentInput = _currentInput.substring(1);
    } else {
      _currentInput = '-$_currentInput';
    }
  }

  /// Calcula porcentaje (%)
  void percentage() {
    if (_hasError) return;
    final val = double.tryParse(_currentInput);
    if (val != null) {
      final res = val / 100.0;
      _currentInput = _formatNumber(res);
      _shouldResetInput = true;
    }
  }

  /// Formatea números flotantes para eliminar ceros innecesarios (e.g. 5.0 -> '5')
  String _formatNumber(double number) {
    if (number.isInfinite || number.isNaN) return 'Error';
    if (number == number.roundToDouble()) {
      return number.toInt().toString();
    }
    // Redondear a máximo 6 decimales para evitar problemas de precisión flotante IEEE 754
    String str = number.toStringAsFixed(6);
    str = str.replaceAll(RegExp(r'0+$'), '');
    str = str.replaceAll(RegExp(r'\.$'), '');
    return str;
  }
}
