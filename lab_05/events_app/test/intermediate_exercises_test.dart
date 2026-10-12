import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:events_app/screens/intermediate_exercises_screen.dart';

void main() {
  Widget createTestWidget({int initialTab = 0}) {
    return MaterialApp(
      home: IntermediateExercisesScreen(initialTabIndex: initialTab),
    );
  }

  testWidgets('Ejercicio 4: Generación de credencial de nombre y edad reactiva', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(initialTab: 0));
    await tester.pumpAndSettle();

    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(2));

    // Ingresamos nombre y edad
    await tester.enterText(textFields.at(0), 'Yeferson Supa');
    await tester.enterText(textFields.at(1), '21');
    await tester.pumpAndSettle();

    expect(find.text('Yeferson Supa'), findsWidgets);
    expect(find.text('21 años • Juventud'), findsOneWidget);
    expect(find.text('Datos válidos y sincronizados'), findsOneWidget);
  });

  testWidgets('Ejercicio 5: Alternancia de switch on/off', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(initialTab: 1));
    await tester.pumpAndSettle();

    expect(find.text('ESTADO: APAGADO (OFF)'), findsOneWidget);

    // Activamos el SwitchListTile
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.text('ESTADO: ENCENDIDO (ON)'), findsOneWidget);
    expect(find.text('Intensidad de Brillo:'), findsOneWidget);
  });

  testWidgets('Ejercicio 6: Detección de doble clic en contenedor', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(initialTab: 2));
    await tester.pumpAndSettle();

    expect(find.text('Likes acumulados: 0'), findsOneWidget);

    final targetContainer = find.text('¡DOBLE CLIC AQUÍ!');
    expect(targetContainer, findsOneWidget);

    // Ejecutamos doble tap
    await tester.tap(targetContainer);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(targetContainer);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 1000));

    expect(find.text('Likes acumulados: 1'), findsOneWidget);
    expect(find.text('¡Doble clic detectado! (Likes: 1)'), findsOneWidget);
  });
}
