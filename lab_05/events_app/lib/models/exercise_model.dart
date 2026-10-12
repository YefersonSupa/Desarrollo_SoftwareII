import 'package:flutter/material.dart';

enum ExerciseLevel {
  guia,
  basico,
  intermedio,
  avanzado,
}

class ExerciseModel {
  final int number;
  final String title;
  final String description;
  final ExerciseLevel level;
  final IconData icon;
  final List<String> eventTags;
  final String targetRoute;

  const ExerciseModel({
    required this.number,
    required this.title,
    required this.description,
    required this.level,
    required this.icon,
    required this.eventTags,
    required this.targetRoute,
  });

  String get levelLabel {
    switch (level) {
      case ExerciseLevel.guia:
        return 'Fundamentos / Guía';
      case ExerciseLevel.basico:
        return 'Nivel Básico';
      case ExerciseLevel.intermedio:
        return 'Nivel Intermedio';
      case ExerciseLevel.avanzado:
        return 'Nivel Avanzado';
    }
  }

  Color get levelColor {
    switch (level) {
      case ExerciseLevel.guia:
        return Colors.indigo;
      case ExerciseLevel.basico:
        return Colors.teal;
      case ExerciseLevel.intermedio:
        return Colors.orange;
      case ExerciseLevel.avanzado:
        return Colors.deepPurple;
    }
  }
}
