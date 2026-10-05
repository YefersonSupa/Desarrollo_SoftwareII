import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_app/models/calculator_logic.dart';

void main() {
  group('Pruebas Unitarias - CalculatorLogic', () {
    late CalculatorLogic calc;

    setUp(() {
      calc = CalculatorLogic();
    });

    test('Estado inicial es 0 y color es gris', () {
      expect(calc.currentInput, '0');
      expect(calc.numericValue, 0.0);
      expect(calc.displayColor, Colors.grey.shade600);
      expect(calc.hasError, false);
    });

    test('Ingreso de dígitos básico', () {
      calc.inputDigit('5');
      calc.inputDigit('8');
      expect(calc.currentInput, '58');
      expect(calc.numericValue, 58.0);
      expect(calc.displayColor, Colors.blue.shade700);
    });

    test('Ingreso de punto decimal sin duplicados', () {
      calc.inputDigit('3');
      calc.inputDecimal();
      calc.inputDigit('1');
      calc.inputDigit('4');
      calc.inputDecimal(); // No debe duplicar
      expect(calc.currentInput, '3.14');
      expect(calc.numericValue, 3.14);
    });

    test('Suma básica y resultado positivo (Color Azul)', () {
      calc.inputDigit('1');
      calc.inputDigit('5');
      calc.setOperator('+');
      calc.inputDigit('2');
      calc.inputDigit('5');
      calc.calculate();

      expect(calc.currentInput, '40');
      expect(calc.numericValue, 40.0);
      expect(calc.displayColor, Colors.blue.shade700);
      expect(calc.history, '15 + 25 =');
    });

    test('Resta que produce resultado negativo (Color Rojo)', () {
      calc.inputDigit('1');
      calc.inputDigit('0');
      calc.setOperator('-');
      calc.inputDigit('3');
      calc.inputDigit('5');
      calc.calculate();

      expect(calc.currentInput, '-25');
      expect(calc.numericValue, -25.0);
      expect(calc.displayColor, Colors.red.shade700);
      expect(calc.history, '10 - 35 =');
    });

    test('Operación que da resultado cero (Color Gris)', () {
      calc.inputDigit('8');
      calc.setOperator('-');
      calc.inputDigit('8');
      calc.calculate();

      expect(calc.currentInput, '0');
      expect(calc.numericValue, 0.0);
      expect(calc.displayColor, Colors.grey.shade600);
    });

    test('Multiplicación con decimales', () {
      calc.inputDigit('2');
      calc.inputDecimal();
      calc.inputDigit('5');
      calc.setOperator('×');
      calc.inputDigit('4');
      calc.calculate();

      expect(calc.currentInput, '10');
      expect(calc.numericValue, 10.0);
      expect(calc.displayColor, Colors.blue.shade700);
    });

    test('División estándar', () {
      calc.inputDigit('1');
      calc.inputDigit('0');
      calc.inputDigit('0');
      calc.setOperator('÷');
      calc.inputDigit('4');
      calc.calculate();

      expect(calc.currentInput, '25');
      expect(calc.numericValue, 25.0);
    });

    test('División por cero maneja Error de forma segura', () {
      calc.inputDigit('9');
      calc.setOperator('÷');
      calc.inputDigit('0');
      calc.calculate();

      expect(calc.currentInput, 'Error');
      expect(calc.hasError, true);
      expect(calc.displayColor, Colors.red.shade700);
    });

    test('Botón C (Clear) restablece el estado completamente', () {
      calc.inputDigit('9');
      calc.setOperator('+');
      calc.inputDigit('5');
      calc.calculate();
      expect(calc.currentInput, '14');

      calc.clear();
      expect(calc.currentInput, '0');
      expect(calc.history, '');
      expect(calc.numericValue, 0.0);
      expect(calc.displayColor, Colors.grey.shade600);
    });

    test('Botón DEL borra el último dígito correctamente', () {
      calc.inputDigit('1');
      calc.inputDigit('2');
      calc.inputDigit('3');
      calc.deleteLast();
      expect(calc.currentInput, '12');
      calc.deleteLast();
      expect(calc.currentInput, '1');
      calc.deleteLast();
      expect(calc.currentInput, '0');
    });

    test('Botón +/- alterna el signo correctamente', () {
      calc.inputDigit('4');
      calc.inputDigit('2');
      calc.toggleSign();
      expect(calc.currentInput, '-42');
      expect(calc.displayColor, Colors.red.shade700);

      calc.toggleSign();
      expect(calc.currentInput, '42');
      expect(calc.displayColor, Colors.blue.shade700);
    });
  });
}
