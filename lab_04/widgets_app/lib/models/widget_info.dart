import 'package:flutter/material.dart';

enum WidgetCategory {
  layout,
  display,
  input,
  navigation,
  feedback;

  String get displayName {
    switch (this) {
      case WidgetCategory.layout:
        return 'Layout';
      case WidgetCategory.display:
        return 'Display';
      case WidgetCategory.input:
        return 'Input';
      case WidgetCategory.navigation:
        return 'Navegación';
      case WidgetCategory.feedback:
        return 'Feedback';
    }
  }

  IconData get icon {
    switch (this) {
      case WidgetCategory.layout:
        return Icons.dashboard_customize_outlined;
      case WidgetCategory.display:
        return Icons.visibility_outlined;
      case WidgetCategory.input:
        return Icons.input_outlined;
      case WidgetCategory.navigation:
        return Icons.navigation_outlined;
      case WidgetCategory.feedback:
        return Icons.notifications_active_outlined;
    }
  }

  Color get color {
    switch (this) {
      case WidgetCategory.layout:
        return const Color(0xFF1E88E5); // Azul layout
      case WidgetCategory.display:
        return const Color(0xFF43A047); // Verde display
      case WidgetCategory.input:
        return const Color(0xFFFB8C00); // Naranja input
      case WidgetCategory.navigation:
        return const Color(0xFF8E24AA); // Púrpura navegación
      case WidgetCategory.feedback:
        return const Color(0xFFE53935); // Rojo feedback
    }
  }
}

class WidgetInfo {
  final String id;
  final String name;
  final WidgetCategory category;
  final String description;
  final List<String> properties;
  final String tip;
  final String codeSample;
  final IconData icon;

  const WidgetInfo({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.properties,
    required this.tip,
    required this.codeSample,
    required this.icon,
  });
}
