import 'package:flutter/material.dart';

/// Centralized breakpoints definition and adaptive design helpers
/// according to Guía 06 - Práctica de Diseño Responsivo y Accesible (UNSAAC).
class Breakpoints {
  // Breakpoint thresholds in logical pixels
  static const double mobile = 480;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double wide = 1440;

  /// Checks if the current screen width is considered Mobile (< 480px)
  static bool isMobile(BuildContext ctx) =>
      MediaQuery.sizeOf(ctx).width < mobile;

  /// Checks if the current screen width is considered Tablet (480px - 1024px)
  static bool isTablet(BuildContext ctx) {
    final w = MediaQuery.sizeOf(ctx).width;
    return w >= mobile && w < desktop;
  }

  /// Checks if the current screen width is considered Desktop (>= 1024px)
  static bool isDesktop(BuildContext ctx) =>
      MediaQuery.sizeOf(ctx).width >= desktop;

  /// Returns a human-readable description of the current active form factor
  static String getDeviceType(BuildContext ctx) {
    final w = MediaQuery.sizeOf(ctx).width;
    if (w < mobile) return 'Móvil Compacto (< 480px)';
    if (w < tablet) return 'Móvil Grande / Phablet (480px - 768px)';
    if (w < desktop) return 'Tablet / Pantalla Mediana (768px - 1024px)';
    if (w < wide) return 'Escritorio Estándar (1024px - 1440px)';
    return 'Pantalla Ultra-Ancha (>= 1440px)';
  }

  /// Calculates dynamic columns for a grid given container constraints
  static int getDynamicColumns(double maxWidth, {double idealCellWidth = 220}) {
    return (maxWidth / idealCellWidth).floor().clamp(1, 6);
  }
}
