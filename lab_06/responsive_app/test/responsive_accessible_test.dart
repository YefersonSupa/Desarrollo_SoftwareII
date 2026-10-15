import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_app/main.dart';
import 'package:responsive_app/models/catalog_item.dart';
import 'package:responsive_app/models/checklist_item.dart';
import 'package:responsive_app/utils/breakpoints.dart';

void main() {
  group('Práctica 06 - Pruebas Unitarias de Lógica y Breakpoints', () {
    test('Breakpoints: Cálculo de columnas dinámicas para grilla adaptativa', () {
      expect(Breakpoints.getDynamicColumns(360, idealCellWidth: 200), equals(1));
      expect(Breakpoints.getDynamicColumns(600, idealCellWidth: 200), equals(3));
      expect(Breakpoints.getDynamicColumns(900, idealCellWidth: 200), equals(4));
      expect(Breakpoints.getDynamicColumns(1400, idealCellWidth: 200), equals(6));
    });

    test('CatalogItem: Dataset de muestra contiene 8 elementos con semántica completa', () {
      final items = CatalogItem.sampleItems();
      expect(items.length, equals(8));
      for (final item in items) {
        expect(item.title.isNotEmpty, isTrue);
        expect(item.semanticDescription.isNotEmpty, isTrue);
        expect(item.rating, greaterThanOrEqualTo(4.0));
      }
    });

    test('ChecklistItem: Los 20 criterios oficiales de la Guía 06 están presentes', () {
      final checklist = ChecklistItem.defaultList();
      expect(checklist.length, equals(20));

      final categories = checklist.map((i) => i.category).toSet();
      expect(categories, containsAll([
        'Diseño Responsivo',
        'Texto y Tipografía',
        'Accesibilidad',
        'Pruebas',
      ]));
    });
  });

  group('Práctica 06 - Pruebas de Widgets y Accesibilidad', () {
    testWidgets('1. Renderizado inicial de la aplicación y navegación móvil', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ResponsiveAccessibleApp());
      await tester.pumpAndSettle();

      // Verificar que el título de la pantalla 1 está presente
      expect(find.text('1. Diseño Responsivo'), findsOneWidget);

      // Verificar que en móvil (<480) se renderiza NavigationBar inferior
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);
    });

    testWidgets('2. Adaptabilidad Desktop: Renderiza NavigationRail en pantallas anchas', (tester) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ResponsiveAccessibleApp());
      await tester.pumpAndSettle();

      // En desktop (1200px) debe aparecer NavigationRail
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('3. Navegación a Adaptive Grid y presencia de tarjetas', (tester) async {
      tester.view.physicalSize = const Size(600, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ResponsiveAccessibleApp());
      await tester.pumpAndSettle();

      // Tap en Adaptive Grid
      await tester.tap(find.text('Adaptive Grid'));
      await tester.pumpAndSettle();

      expect(find.text('2. Adaptive Grid & Breakpoints'), findsOneWidget);
      expect(find.text('Reporte de Alumbrado Público'), findsOneWidget);
    });

    testWidgets('4. Verificación de Touch Target óptimo (48x48 px)', (tester) async {
      tester.view.physicalSize = const Size(600, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ResponsiveAccessibleApp());
      await tester.pumpAndSettle();

      // Navegar a Accesibilidad
      await tester.tap(find.text('Accesibilidad'));
      await tester.pumpAndSettle();

      expect(find.text('3. Accesibilidad & Ergonomía'), findsOneWidget);
      expect(find.text('Área accesible: 48x48 px'), findsOneWidget);
    });

    testWidgets('5. Verificación de Semántica y MergeSemantics', (tester) async {
      tester.view.physicalSize = const Size(600, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ResponsiveAccessibleApp());
      await tester.pumpAndSettle();

      // Navegar a Semántica
      await tester.tap(find.text('Semántica'));
      await tester.pumpAndSettle();

      expect(find.text('4. Semántica & Lectores de Pantalla'), findsOneWidget);
      expect(find.byType(MergeSemantics), findsWidgets);
      expect(find.byType(ExcludeSemantics), findsWidgets);
    });

    testWidgets('6. Verificación de Checklist interactivo y toggle de ítems', (tester) async {
      tester.view.physicalSize = const Size(600, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ResponsiveAccessibleApp());
      await tester.pumpAndSettle();

      // Navegar a Checklist
      await tester.tap(find.text('Checklist'));
      await tester.pumpAndSettle();

      expect(find.text('5. Checklist de Lanzamiento'), findsOneWidget);
      expect(find.text('Auditoría de Calidad WCAG & Responsividad'), findsOneWidget);
    });
  });
}
