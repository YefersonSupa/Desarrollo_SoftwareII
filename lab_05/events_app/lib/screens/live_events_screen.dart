import 'package:flutter/material.dart';
import '../services/event_bus.dart';
import '../models/event_log.dart';
import '../widgets/custom_app_bar.dart';

class LiveEventsScreen extends StatefulWidget {
  const LiveEventsScreen({super.key});

  @override
  State<LiveEventsScreen> createState() => _LiveEventsScreenState();
}

class _LiveEventsScreenState extends State<LiveEventsScreen> {
  EventType? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Monitor de Eventos en Vivo',
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.white),
            tooltip: 'Limpiar registros',
            onPressed: () {
              EventBus().clear();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registros de eventos limpiados')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            color: Colors.grey.shade100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('Todos'),
                    selected: _selectedFilter == null,
                    onSelected: (_) => setState(() => _selectedFilter = null),
                  ),
                  const SizedBox(width: 8),
                  ...EventType.values.map((type) {
                    final label = type.name.toUpperCase();
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(label),
                        selected: _selectedFilter == type,
                        onSelected: (selected) {
                          setState(() {
                            _selectedFilter = selected ? type : null;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<EventLog>>(
              valueListenable: EventBus().logsNotifier,
              builder: (context, logs, _) {
                final filteredLogs = _selectedFilter == null
                    ? logs
                    : logs.where((l) => l.type == _selectedFilter).toList();

                if (filteredLogs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.monitor_heart_outlined, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        const Text(
                          'No hay eventos registrados en este momento.\nInteractúa con los botones, gestos o inputs.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filteredLogs.length,
                  itemBuilder: (context, index) {
                    final log = filteredLogs[index];
                    return Card(
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: log.badgeColor.withOpacity(0.15),
                          child: Icon(
                            _getIconForEvent(log.type),
                            color: log.badgeColor,
                            size: 20,
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              log.source,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            const Spacer(),
                            Text(
                              log.timeFormatted,
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            log.description,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForEvent(EventType type) {
    switch (type) {
      case EventType.tap:
        return Icons.touch_app;
      case EventType.doubleTap:
        return Icons.double_arrow;
      case EventType.longPress:
        return Icons.touch_app_outlined;
      case EventType.changed:
        return Icons.edit;
      case EventType.submitted:
        return Icons.send;
      case EventType.drag:
        return Icons.swipe;
      case EventType.toggle:
        return Icons.toggle_on;
      case EventType.system:
        return Icons.settings;
    }
  }
}
