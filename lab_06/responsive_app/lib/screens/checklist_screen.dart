import 'package:flutter/material.dart';
import '../models/checklist_item.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final List<ChecklistItem> _items = ChecklistItem.defaultList();
  String _selectedCategory = 'Todos';

  double get _completionRatio {
    if (_items.isEmpty) return 0;
    final done = _items.where((i) => i.isCompleted).length;
    return done / _items.length;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categories = ['Todos', 'Diseño Responsivo', 'Texto y Tipografía', 'Accesibilidad', 'Pruebas'];
    final filtered = _selectedCategory == 'Todos'
        ? _items
        : _items.where((i) => i.category == _selectedCategory).toList();

    final completedCount = _items.where((i) => i.isCompleted).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('5. Checklist de Lanzamiento'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Alternar selección completa',
            icon: Icon(completedCount == _items.length ? Icons.deselect : Icons.select_all),
            onPressed: () {
              final newValue = completedCount != _items.length;
              setState(() {
                for (var item in _items) {
                  item.isCompleted = newValue;
                }
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Panel de Progreso y Métricas
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Auditoría de Calidad WCAG & Responsividad',
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$completedCount de ${_items.length} (${(_completionRatio * 100).toInt()}%)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _completionRatio == 1.0 ? Colors.green : theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: _completionRatio,
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _completionRatio == 1.0 ? Colors.green : theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Filtros de categoría
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((cat) {
                        final isSel = _selectedCategory == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Text(cat),
                            selected: isSel,
                            onSelected: (_) => setState(() => _selectedCategory = cat),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Lista de verificación
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final item = filtered[i];
                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: CheckboxListTile(
                      value: item.isCompleted,
                      title: Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: item.isCompleted ? TextDecoration.none : null,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(item.description, style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item.category,
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                      onChanged: (val) {
                        setState(() {
                          item.isCompleted = val ?? false;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
