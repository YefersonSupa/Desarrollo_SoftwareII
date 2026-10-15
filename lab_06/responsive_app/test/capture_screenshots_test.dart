import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_app/screens/responsive_layout_screen.dart';
import 'package:responsive_app/screens/adaptive_grid_screen.dart';
import 'package:responsive_app/screens/accessibility_screen.dart';
import 'package:responsive_app/screens/semantics_screen.dart';
import 'package:responsive_app/screens/checklist_screen.dart';

Future<void> _capture(WidgetTester tester, GlobalKey key, String path) async {
  await tester.runAsync(() async {
    final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return;
    final image = await boundary.toImage(pixelRatio: 1.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return;
    File(path).writeAsBytesSync(byteData.buffer.asUint8List());
  });
}

Widget _wrap(Widget screen, GlobalKey key) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF003366)),
    ),
    home: RepaintBoundary(key: key, child: screen),
  );
}

void main() {
  testWidgets('Screen 1', (tester) async {
    tester.view.physicalSize = const Size(720, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    final key = GlobalKey();
    await tester.pumpWidget(_wrap(const ResponsiveLayoutScreen(), key));
    await tester.pump();
    await _capture(tester, key, '../ej1.png');
  });

  testWidgets('Screen 2', (tester) async {
    tester.view.physicalSize = const Size(720, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    final key = GlobalKey();
    await tester.pumpWidget(_wrap(const AdaptiveGridScreen(), key));
    await tester.pump();
    await _capture(tester, key, '../ej2.png');
  });

  testWidgets('Screen 3', (tester) async {
    tester.view.physicalSize = const Size(720, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    final key = GlobalKey();
    await tester.pumpWidget(_wrap(
      AccessibilityScreen(
        currentTextScale: 1.2,
        onTextScaleChanged: (_) {},
        isHighContrast: false,
        onHighContrastChanged: (_) {},
      ),
      key,
    ));
    await tester.pump();
    await _capture(tester, key, '../ej3.png');
  });

  testWidgets('Screen 4', (tester) async {
    tester.view.physicalSize = const Size(720, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    final key = GlobalKey();
    await tester.pumpWidget(_wrap(
      SemanticsScreen(
        showSemanticsDebugger: false,
        onToggleSemanticsDebugger: (_) {},
      ),
      key,
    ));
    await tester.pump();
    await _capture(tester, key, '../ej4.png');
  });

  testWidgets('Screen 5', (tester) async {
    tester.view.physicalSize = const Size(720, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    final key = GlobalKey();
    await tester.pumpWidget(_wrap(const ChecklistScreen(), key));
    await tester.pump();
    await _capture(tester, key, '../ej5.png');
  });
}
