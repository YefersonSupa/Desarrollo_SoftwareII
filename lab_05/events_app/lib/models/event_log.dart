import 'package:flutter/material.dart';

/// Tipo de evento capturado en la aplicación
enum EventType {
  tap,
  doubleTap,
  longPress,
  changed,
  submitted,
  drag,
  toggle,
  system,
}

/// Registro de auditoría de un evento para el monitor en vivo
class EventLog {
  final String id;
  final String source;
  final EventType type;
  final String description;
  final DateTime timestamp;
  final Color badgeColor;

  EventLog({
    required this.id,
    required this.source,
    required this.type,
    required this.description,
    DateTime? timestamp,
    Color? badgeColor,
  })  : timestamp = timestamp ?? DateTime.now(),
        badgeColor = badgeColor ?? _defaultColor(type);

  static Color _defaultColor(EventType type) {
    switch (type) {
      case EventType.tap:
        return Colors.blue;
      case EventType.doubleTap:
        return Colors.purple;
      case EventType.longPress:
        return Colors.orange;
      case EventType.changed:
        return Colors.green;
      case EventType.submitted:
        return Colors.teal;
      case EventType.drag:
        return Colors.indigo;
      case EventType.toggle:
        return Colors.amber.shade800;
      case EventType.system:
        return Colors.grey.shade700;
    }
  }

  String get timeFormatted {
    final h = timestamp.hour.toString().padLeft(2, '0');
    final m = timestamp.minute.toString().padLeft(2, '0');
    final s = timestamp.second.toString().padLeft(2, '0');
    final ms = timestamp.millisecond.toString().padLeft(3, '0');
    return '$h:$m:$s.$ms';
  }
}
