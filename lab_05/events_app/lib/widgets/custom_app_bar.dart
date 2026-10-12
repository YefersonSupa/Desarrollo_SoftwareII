import 'package:flutter/material.dart';
import '../services/event_bus.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      centerTitle: true,
      elevation: 2,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                : [const Color(0xFF003366), const Color(0xFF1976D2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      actions: [
        ValueListenableBuilder<int>(
          valueListenable: EventBus().totalEventsCount,
          builder: (context, count, _) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Tooltip(
                  message: 'Total de eventos disparados en la sesión: $count',
                  child: Chip(
                    visualDensity: VisualDensity.compact,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    side: BorderSide.none,
                    avatar: const Icon(Icons.flash_on, size: 16, color: Colors.amber),
                    label: Text(
                      '$count ev.',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        ...?actions,
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
