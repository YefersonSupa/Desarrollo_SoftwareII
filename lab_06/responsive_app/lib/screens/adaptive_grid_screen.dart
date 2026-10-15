import 'package:flutter/material.dart';
import '../models/catalog_item.dart';
import '../utils/breakpoints.dart';

class AdaptiveGridScreen extends StatefulWidget {
  const AdaptiveGridScreen({super.key});

  @override
  State<AdaptiveGridScreen> createState() => _AdaptiveGridScreenState();
}

class _AdaptiveGridScreenState extends State<AdaptiveGridScreen> {
  final List<CatalogItem> _items = CatalogItem.sampleItems();
  double _maxCrossAxisExtent = 220.0;
  bool _useExplicitLayoutBuilder = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('2. Adaptive Grid & Breakpoints'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Barra de control de parámetros adaptativos
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Ancho disponible: ${size.width.toStringAsFixed(0)} px | Form factor: ${Breakpoints.getDeviceType(context)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      FilterChip(
                        label: Text(_useExplicitLayoutBuilder ? 'Modo LayoutBuilder' : 'Modo MaxExtent'),
                        selected: _useExplicitLayoutBuilder,
                        onSelected: (val) => setState(() => _useExplicitLayoutBuilder = val),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('maxExtent:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      Expanded(
                        child: Slider(
                          value: _maxCrossAxisExtent,
                          min: 160,
                          max: 340,
                          divisions: 9,
                          label: '${_maxCrossAxisExtent.toInt()} px',
                          onChanged: (val) => setState(() => _maxCrossAxisExtent = val),
                        ),
                      ),
                      Text('${_maxCrossAxisExtent.toInt()} px', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),

            // Grilla adaptativa
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _useExplicitLayoutBuilder
                    ? LayoutBuilder(
                        builder: (context, constraints) {
                          final cols = (constraints.maxWidth / _maxCrossAxisExtent).floor().clamp(1, 6);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Columnas calculadas dinámicamente con LayoutBuilder: $cols columnas',
                                  style: TextStyle(fontWeight: FontWeight.w600, color: theme.colorScheme.primary),
                                ),
                              ),
                              Expanded(
                                child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: cols,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.85,
                                  ),
                                  itemCount: _items.length,
                                  itemBuilder: (context, i) => _buildItemCard(context, _items[i]),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: _maxCrossAxisExtent,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _items.length,
                        itemBuilder: (context, i) => _buildItemCard(context, _items[i]),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, CatalogItem item) {
    final theme = Theme.of(context);
    return Semantics(
      label: item.semanticDescription,
      button: true,
      hint: 'Doble toque para ver detalles de ${item.title}',
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Seleccionado: ${item.title}')),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: item.accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(item.icon, color: item.accentColor, size: 24),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(
                          item.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  item.category.toUpperCase(),
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: item.accentColor, letterSpacing: 0.8),
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: Text(
                    item.description,
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Ver más →',
                    style: TextStyle(color: item.accentColor, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
