import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_app/main.dart';
import 'package:widgets_app/data/widgets_data.dart';

void main() {
  test('Verificar integridad del dataset de 25 widgets', () {
    expect(kWidgetsList.length, 25);
    final layoutCount = kWidgetsList.where((w) => w.category.name == 'layout').length;
    final displayCount = kWidgetsList.where((w) => w.category.name == 'display').length;
    final inputCount = kWidgetsList.where((w) => w.category.name == 'input').length;
    final navCount = kWidgetsList.where((w) => w.category.name == 'navigation').length;
    final feedbackCount = kWidgetsList.where((w) => w.category.name == 'feedback').length;

    expect(layoutCount, 6);
    expect(displayCount, 6);
    expect(inputCount, 5);
    expect(navCount, 4);
    expect(feedbackCount, 4);
    expect(kGeneralTips.length, 10);
  });

  testWidgets('Renderizado inicial de la aplicación y cabecera UNSAAC', (WidgetTester tester) async {
    await tester.pumpWidget(const WidgetsGuideApp());
    await tester.pumpAndSettle();

    // Comprobar título del AppBar y banner institucional
    expect(find.text('Guía Práctica de Widgets en Flutter'), findsOneWidget);
    expect(find.textContaining('UNSAAC'), findsWidgets);
    expect(find.textContaining('Yeferson Supa'), findsOneWidget);

    // Comprobar métricas rápidas
    expect(find.text('25'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('Búsqueda reactiva de widgets por texto', (WidgetTester tester) async {
    await tester.pumpWidget(const WidgetsGuideApp());
    await tester.pumpAndSettle();

    // Escribir en el campo de búsqueda
    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    await tester.enterText(searchField, 'Container');
    await tester.pumpAndSettle();

    // Debe filtrar y encontrar el widget Container
    expect(find.text('Container'), findsWidgets);
    expect(find.text('ElevatedButton'), findsNothing);
  });

  testWidgets('Navegación hacia la pantalla de Layout y regreso', (WidgetTester tester) async {
    await tester.pumpWidget(const WidgetsGuideApp());
    await tester.pumpAndSettle();

    // Pulsar en la categoría Layout
    final layoutCard = find.textContaining('1. Layout (Organización Espacial)');
    expect(layoutCard, findsOneWidget);

    await tester.tap(layoutCard);
    await tester.pumpAndSettle();

    // Verificar que estamos en la pantalla de Layout
    expect(find.text('Widgets de Layout (6)'), findsOneWidget);
    expect(find.text('Container'), findsWidgets);

    // Regresar
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    expect(find.text('Guía Práctica de Widgets en Flutter'), findsOneWidget);
  });

  testWidgets('Alternar modo de tema claro / oscuro', (WidgetTester tester) async {
    await tester.pumpWidget(const WidgetsGuideApp());
    await tester.pumpAndSettle();

    final themeToggleBtn = find.byTooltip('Cambiar a modo oscuro');
    expect(themeToggleBtn, findsOneWidget);

    await tester.tap(themeToggleBtn);
    await tester.pumpAndSettle();

    // Ahora el tooltip debe indicar cambio a modo claro
    expect(find.byTooltip('Cambiar a modo claro'), findsOneWidget);
  });
}
