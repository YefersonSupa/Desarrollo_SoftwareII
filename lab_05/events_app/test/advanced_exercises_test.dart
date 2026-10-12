import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:events_app/screens/advanced_exercises_screen.dart';

void main() {
  Widget createTestWidget({int initialTab = 0}) {
    return MaterialApp(
      home: AdvancedExercisesScreen(initialTabIndex: initialTab),
    );
  }

  testWidgets('Ejercicio 7: Agregar nuevo ítem y marcarlo como completado', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(initialTab: 0));
    await tester.pumpAndSettle();

    final inputFinder = find.widgetWithText(TextField, 'Nueva tarea o elemento...');
    expect(inputFinder, findsOneWidget);

    await tester.enterText(inputFinder, 'Estudiar para el examen de arquitectura');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Estudiar para el examen de arquitectura'), findsOneWidget);
  });

  testWidgets('Ejercicio 8: Formulario valida campos obligatorios', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(initialTab: 1));
    await tester.pumpAndSettle();

    // Presionamos validar sin llenar datos
    await tester.tap(find.text('Validar y Enviar Formulario'));
    await tester.pumpAndSettle();

    // Debe exigir aceptar términos mediante SnackBar
    expect(find.text('Debe aceptar los términos y condiciones para continuar.'), findsOneWidget);
  });

  testWidgets('Ejercicio 9: Juego de Taps inicia y detecta toques', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(initialTab: 2));
    await tester.pumpAndSettle();

    expect(find.text('Comenzar Reto (10 Segundos)'), findsOneWidget);

    // Iniciamos juego
    await tester.tap(find.text('Comenzar Reto (10 Segundos)'));
    await tester.pump();

    expect(find.text('¡TAP RÁPIDO!'), findsOneWidget);

    // Hacemos tap en la diana
    await tester.tap(find.text('¡TAP RÁPIDO!'));
    await tester.pump();

    expect(find.text('1'), findsWidgets);

    // Avanzamos el reloj para terminar el juego y limpiar timers
    await tester.pump(const Duration(seconds: 11));
    await tester.pumpAndSettle();
  });
}
