// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:hola_mundo/main.dart';

void main() {
  testWidgets('Prueba de humo para UnsaacMobileApp', (WidgetTester tester) async {
    // Construir la app y renderizar el primer frame
    await tester.pumpWidget(const UnsaacMobileApp());

    // Verificar que el saludo inicial está presente
    expect(find.text('¡Hola Mundo móvil! 📱'), findsOneWidget);

    // Asegurar que el botón sea visible y simular el toque
    final boton = find.text('Presióname para cambiar el saludo');
    await tester.ensureVisible(boton);
    await tester.tap(boton);
    await tester.pumpAndSettle();

    // Verificar que el mensaje cambió
    expect(find.text('Bienvenido a Desarrollo de Aplicaciones Móviles'), findsOneWidget);
  });
}
