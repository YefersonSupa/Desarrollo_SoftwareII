import 'package:flutter/material.dart';

enum PriorityLevel { low, medium, high }

class DynamicItem {
  final String id;
  String title;
  String category;
  PriorityLevel priority;
  bool isCompleted;
  final DateTime createdAt;

  DynamicItem({
    required this.id,
    required this.title,
    this.category = 'General',
    this.priority = PriorityLevel.medium,
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Color get priorityColor {
    switch (priority) {
      case PriorityLevel.high:
        return Colors.redAccent;
      case PriorityLevel.medium:
        return Colors.amber.shade700;
      case PriorityLevel.low:
        return Colors.green;
    }
  }

  String get priorityText {
    switch (priority) {
      case PriorityLevel.high:
        return 'Alta';
      case PriorityLevel.medium:
        return 'Media';
      case PriorityLevel.low:
        return 'Baja';
    }
  }
}
