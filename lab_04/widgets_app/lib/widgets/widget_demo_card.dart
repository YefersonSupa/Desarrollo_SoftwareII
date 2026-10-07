import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/widget_info.dart';

class WidgetDemoCard extends StatefulWidget {
  final WidgetInfo info;
  final Widget interactiveDemo;
  final Widget? controls;

  const WidgetDemoCard({
    super.key,
    required this.info,
    required this.interactiveDemo,
    this.controls,
  });

  @override
  State<WidgetDemoCard> createState() => _WidgetDemoCardState();
}

class _WidgetDemoCardState extends State<WidgetDemoCard> {
  bool _showCode = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: widget.info.category.color.withOpacity(0.12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: widget.info.category.color,
                  child: Icon(widget.info.icon, size: 20, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.info.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: widget.info.category.color,
                        ),
                      ),
                      Text(
                        widget.info.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: _showCode ? 'Ocultar código' : 'Ver código Dart',
                  icon: Icon(
                    _showCode ? Icons.code_off : Icons.code,
                    color: widget.info.category.color,
                  ),
                  onPressed: () {
                    setState(() {
                      _showCode = !_showCode;
                    });
                  },
                ),
              ],
            ),
          ),

          // Chips de propiedades principales
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Propiedades:',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                ...widget.info.properties.map(
                  (prop) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withOpacity(0.4),
                      ),
                    ),
                    child: Text(
                      prop,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Controles de interactividad si existen
          if (widget.controls != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: widget.controls!,
            ),
          ],

          const Divider(height: 1),

          // Área de Demostración Interactiva
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant.withOpacity(0.2),
            ),
            child: Center(
              child: widget.interactiveDemo,
            ),
          ),

          // Código fuente expandible
          if (_showCode) ...[
            Container(
              padding: const EdgeInsets.all(14),
              color: const Color(0xFF1E1E2E), // Paleta moderna dark slate
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ejemplo de código Dart:',
                        style: TextStyle(
                          color: Color(0xFF90CAF9),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.copy, size: 16, color: Colors.white70),
                        tooltip: 'Copiar código',
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: widget.info.codeSample));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Código copiado al portapapeles'),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  SelectableText(
                    widget.info.codeSample,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Color(0xFFA6E3A1),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Banner del Consejo 💡
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.08),
              border: Border(
                top: BorderSide(color: Colors.amber.withOpacity(0.25)),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💡', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.info.tip,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.brightness == Brightness.dark
                          ? Colors.amber.shade200
                          : Colors.amber.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
