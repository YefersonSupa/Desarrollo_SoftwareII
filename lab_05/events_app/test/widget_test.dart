import 'package:flutter_test/flutter_test.dart';
import 'package:events_app/main.dart';

void main() {
  testWidgets('Smoke test: EventsApp carga el Dashboard institucional correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(const EventsApp());
    await tester.pumpAndSettle();

    // Verificamos que el título y encabezados institucionales estén presentes
    expect(find.text('Práctica 05: Eventos e Interactividad'), findsOneWidget);
    expect(find.text('Manejo de Eventos e Interactividad en Flutter'), findsOneWidget);
    expect(find.text('Catálogo de los 9 Ejercicios Propuestos:'), findsOneWidget);

    // Verificamos presencia de los accesos rápidos y estadísticas
    expect(find.text('Guía Oficial'), findsWidgets);
    expect(find.text('Básico (1-3)'), findsOneWidget);
    expect(find.text('Intermedio (4-6)'), findsOneWidget);
    expect(find.text('Avanzado (7-9)'), findsOneWidget);
  });
}
