import 'package:flutter/material.dart';
import '../../data/widgets_data.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  IconData _resolveIcon(String iconName) {
    switch (iconName) {
      case 'widgets':
        return Icons.widgets_outlined;
      case 'speed':
        return Icons.speed_outlined;
      case 'layers':
        return Icons.layers_outlined;
      case 'account_tree':
        return Icons.account_tree_outlined;
      case 'bug_report':
        return Icons.bug_report_outlined;
      case 'flash_on':
        return Icons.flash_on_outlined;
      case 'auto_awesome':
        return Icons.auto_awesome_outlined;
      case 'devices':
        return Icons.devices_outlined;
      case 'aspect_ratio':
        return Icons.aspect_ratio_outlined;
      case 'palette':
        return Icons.palette_outlined;
      default:
        return Icons.lightbulb_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consejos Generales de Flutter'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.deepPurple.shade50,
            margin: const EdgeInsets.only(bottom: 16),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.school, color: Colors.deepPurple, size: 36),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Decálogo de Buenas Prácticas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Recomendaciones esenciales para construir arquitecturas eficientes, mantenibles y reactivas en Flutter y Dart.',
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...List.generate(kGeneralTips.length, (index) {
            final tip = kGeneralTips[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.deepPurple.shade100),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple.shade100,
                  foregroundColor: Colors.deepPurple.shade800,
                  child: Icon(_resolveIcon(tip['icon'] ?? '')),
                ),
                title: Text(
                  '${index + 1}. ${tip['title']!}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 4),
                  child: Text(
                    tip['desc']!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
