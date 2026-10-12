import 'package:flutter/foundation.dart';
import '../models/event_log.dart';

/// Bus global y reactivo para capturar y auditar eventos de la aplicación
class EventBus {
  static final EventBus _instance = EventBus._internal();
  factory EventBus() => _instance;
  EventBus._internal();

  final ValueNotifier<List<EventLog>> logsNotifier = ValueNotifier<List<EventLog>>([]);
  final ValueNotifier<int> totalEventsCount = ValueNotifier<int>(0);

  List<EventLog> get logs => logsNotifier.value;

  void emit({
    required String source,
    required EventType type,
    required String description,
  }) {
    final newLog = EventLog(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      source: source,
      type: type,
      description: description,
    );

    // Mantenemos los últimos 100 eventos
    final updatedList = [newLog, ...logsNotifier.value];
    if (updatedList.length > 100) {
      updatedList.removeLast();
    }
    logsNotifier.value = updatedList;
    totalEventsCount.value += 1;
  }

  void clear() {
    logsNotifier.value = [];
  }
}
