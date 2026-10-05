import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_app/main.dart';

Future<void> _captureWidget(
  WidgetTester tester,
  GlobalKey key,
  String outputPath,
) async {
  final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
  if (boundary == null) return;
  final image = await boundary.toImage(pixelRatio: 2.0);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  if (byteData == null) return;
  final pngBytes = byteData.buffer.asUint8List();
  File(outputPath).writeAsBytesSync(pngBytes);
}

void main() {
  testWidgets('Generar capturas de evidencia para informe', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2200);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(() => tester.view.resetPhysicalSize());

    final repaintKey = GlobalKey();

    // 1. Captura de Calculadora en Reposo (Cero - Gris)
    await tester.pumpWidget(
      RepaintBoundary(
        key: repaintKey,
        child: const Laboratorio03App(),
      ),
    );
    await tester.pumpAndSettle();
    await _captureWidget(tester, repaintKey, '../evidencia_calculadora_cero.png');

    // 2. Operación Positiva (Azul) 15 + 25 = 40
    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('5'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('+'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('2'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('5'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('='));
    await tester.pumpAndSettle();
    await _captureWidget(tester, repaintKey, '../evidencia_calculadora_positivo.png');

    // 3. Operación Negativa (Rojo) C, luego 10 - 35 = -25
    await tester.tap(find.text('C'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('0'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('-'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('3'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('5'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('='));
    await tester.pumpAndSettle();
    await _captureWidget(tester, repaintKey, '../evidencia_calculadora_negativo.png');

    // 4. Ejercicio 1 (Hola Mundo)
    await tester.tap(find.byIcon(Icons.waving_hand_outlined));
    await tester.pumpAndSettle();
    await _captureWidget(tester, repaintKey, '../evidencia_ejercicio1_holamundo.png');

    // 5. Ejercicio 2 (Tarjeta de Perfil Ada Lovelace)
    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();
    await _captureWidget(tester, repaintKey, '../evidencia_ejercicio2_perfil.png');

    // 6. Ejercicio 3 (Contador Interactivo)
    await tester.tap(find.byIcon(Icons.exposure_plus_1_outlined));
    await tester.pumpAndSettle();
    // Incrementar varias veces para ver color
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await _captureWidget(tester, repaintKey, '../evidencia_ejercicio3_contador.png');
  });
}
