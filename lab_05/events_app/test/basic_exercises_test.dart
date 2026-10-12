import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:events_app/screens/basic_exercises_screen.dart';

void main() {
  Widget createTestWidget({int initialTab = 0}) {
    return MaterialApp(
      home: BasicExercisesScreen(initialTabIndex: initialTab),
    );
  }

  testWidgets('Ejercicio 1: Botón de color y chips predefinidos', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(initialTab: 0));
    await tester.pumpAndSettle();

    // Verificamos presencia de elementos del Ejercicio 1
    expect(find.text('Color Activo: #003366'), findsOneWidget);
    expect(find.text('Generar Color Aleatorio (setState)'), findsOneWidget);

    // Tocamos chip de color Esmeralda
    await tester.tap(find.text('Esmeralda'));
    await tester.pumpAndSettle();

    // El color activo debió cambiar
    expect(find.text('Color Activo: #10B981'), findsOneWidget);
  });

  testWidgets('Ejercicio 2: Contador interactivo incrementa, decrementa y reinicia', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(initialTab: 1));
    await tester.pumpAndSettle();

    // Valor inicial debe ser 0
    expect(find.text('0'), findsWidgets);

    // Tocamos el botón de incrementar (+1)
    await tester.tap(find.text('+1'));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsWidgets);

    // Tocamos el botón de decrementar (-1) dos veces
    await tester.tap(find.text('-1'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('-1'));
    await tester.pumpAndSettle();
    expect(find.text('-1'), findsWidgets);

    // Presionamos reiniciar
    await tester.tap(find.text('Reiniciar a Cero (Reset)'));
    await tester.pumpAndSettle();
    expect(find.text('0'), findsWidgets);
  });

  testWidgets('Ejercicio 3: Captura de texto reactivo y estadísticas en vivo', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(initialTab: 2));
    await tester.pumpAndSettle();

    final inputFinder = find.byType(TextField);
    expect(inputFinder, findsOneWidget);

    // Ingresamos un palíndromo "radar"
    await tester.enterText(inputFinder, 'radar');
    await tester.pumpAndSettle();

    expect(find.text('radar'), findsWidgets);
    expect(find.text('Caracteres: 5'), findsOneWidget);
    expect(find.text('Palabras: 1'), findsOneWidget);
    expect(find.text('¡Es un Palíndromo!'), findsOneWidget);
  });
}
