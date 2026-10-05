import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_app/main.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Pruebas de Widgets y UI Interactivas - Calculadora & Navegación', () {
    testWidgets('Flujo completo: suma, resta con resultado negativo y reseteo C',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.75;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const Laboratorio03App());
      await tester.pumpAndSettle();

      // Verificar pantalla inicial
      expect(find.text('Calculadora Flutter - Ejercicio Propuesto'), findsOneWidget);
      expect(find.text('Cero (Gris)'), findsOneWidget);

      // Realizar una resta negativa: 5 - 9 = -4
      await tester.tap(find.text('5'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('-'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('9'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('='));
      await tester.pumpAndSettle();

      // Debe mostrar -4 y el badge "Negativo (Rojo)"
      expect(find.text('-4'), findsOneWidget);
      expect(find.text('Negativo (Rojo)'), findsOneWidget);

      // Probar borrado C
      await tester.tap(find.text('C'));
      await tester.pumpAndSettle();
      expect(find.text('0'), findsWidgets);
      expect(find.text('Cero (Gris)'), findsOneWidget);

      // Probar división por cero: 8 ÷ 0 = Error
      await tester.tap(find.text('8'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('÷'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('0'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('='));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('display_text')), findsOneWidget);
      expect(find.text('Error'), findsNWidgets(2));
    });

    testWidgets('Navegación completa entre los 4 ejercicios del laboratorio',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.75;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const Laboratorio03App());
      await tester.pumpAndSettle();

      // 1. Ir a Ejercicio 1 (Hola Mundo)
      await tester.tap(find.byIcon(Icons.waving_hand_outlined));
      await tester.pumpAndSettle();
      expect(find.text('¡Hola, Flutter!'), findsOneWidget);
      expect(find.text('Primer proyecto en Android Studio'), findsOneWidget);

      // 2. Ir a Ejercicio 2 (Tarjeta de Perfil Ada Lovelace)
      await tester.tap(find.byIcon(Icons.person_outline));
      await tester.pumpAndSettle();
      expect(find.text('Ada Lovelace'), findsOneWidget);
      expect(find.text('Ingeniería Informática'), findsOneWidget);
      expect(find.text('Proyectos'), findsOneWidget);
      expect(find.text('Enviar Mensaje'), findsOneWidget);

      // 3. Ir a Ejercicio 3 (Contador Interactivo)
      await tester.tap(find.byIcon(Icons.exposure_plus_1_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Contador Interactivo - Ejercicio 3'), findsOneWidget);
      expect(find.text('Valor actual:'), findsOneWidget);

      // Probar incrementar en el contador
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);

      // 4. Regresar a Calculadora
      await tester.tap(find.byIcon(Icons.calculate_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Calculadora Flutter - Ejercicio Propuesto'), findsOneWidget);
    });
  });
}
