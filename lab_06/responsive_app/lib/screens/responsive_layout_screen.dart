import 'package:flutter/material.dart';
import '../utils/breakpoints.dart';

class ResponsiveLayoutScreen extends StatefulWidget {
  const ResponsiveLayoutScreen({super.key});

  @override
  State<ResponsiveLayoutScreen> createState() => _ResponsiveLayoutScreenState();
}

class _ResponsiveLayoutScreenState extends State<ResponsiveLayoutScreen> {
  double _fractionFactor = 0.8;
  int _searchFlex = 2;
  int _buttonFlex = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final deviceType = Breakpoints.getDeviceType(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('1. Diseño Responsivo'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Panel 1: Monitor en tiempo real de MediaQuery
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.monitor_rounded, color: theme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Monitor de Pantalla (MediaQuery.sizeOf)',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      Wrap(
                        spacing: 12,
                        runSpacing: 10,
                        children: [
                          _buildMetricChip(
                            context,
                            label: 'Ancho (Width)',
                            value: '${size.width.toStringAsFixed(1)} px',
                            icon: Icons.width_full,
                          ),
                          _buildMetricChip(
                            context,
                            label: 'Alto (Height)',
                            value: '${size.height.toStringAsFixed(1)} px',
                            icon: Icons.height,
                          ),
                          _buildMetricChip(
                            context,
                            label: 'Orientación',
                            value: isLandscape ? 'Horizontal (Landscape)' : 'Vertical (Portrait)',
                            icon: isLandscape ? Icons.stay_current_landscape : Icons.stay_current_portrait,
                          ),
                          _buildMetricChip(
                            context,
                            label: 'Form Factor Detectado',
                            value: deviceType,
                            icon: Icons.devices_rounded,
                            isHighlighted: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Panel 2: LayoutBuilder demostrativo
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.dashboard_customize_rounded, color: theme.colorScheme.secondary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'LayoutBuilder: Row vs Column Dinámico',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Se adapta al espacio del contenedor padre (maxWidth > 600px genera Row, sino Column).',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 16),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth > 600;
                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: theme.colorScheme.outlineVariant),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Restricción local: maxWidth = ${constraints.maxWidth.toStringAsFixed(1)} px '
                                  '(${isWide ? "Modo Fila > 600px" : "Modo Columna <= 600px"})',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isWide ? Colors.indigo : Colors.deepOrange,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                if (isWide)
                                  Row(
                                    children: [
                                      Expanded(child: _buildSampleCard('Panel A (50% Ancho)', Colors.blue.shade100, Colors.blue.shade900)),
                                      const SizedBox(width: 12),
                                      Expanded(child: _buildSampleCard('Panel B (50% Ancho)', Colors.teal.shade100, Colors.teal.shade900)),
                                    ],
                                  )
                                else
                                  Column(
                                    children: [
                                      _buildSampleCard('Panel A (100% Ancho Móvil)', Colors.blue.shade100, Colors.blue.shade900),
                                      const SizedBox(height: 8),
                                      _buildSampleCard('Panel B (100% Ancho Móvil)', Colors.teal.shade100, Colors.teal.shade900),
                                    ],
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Panel 3: FractionallySizedBox
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.aspect_ratio_rounded, color: Colors.purple),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'FractionallySizedBox (Proporción Relativa)',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Evita anchos fijos en píxeles. Ajusta el factor de escala relativo del botón:',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                      ),
                      Slider(
                        value: _fractionFactor,
                        min: 0.3,
                        max: 1.0,
                        divisions: 7,
                        label: '${(_fractionFactor * 100).toInt()}%',
                        onChanged: (val) => setState(() => _fractionFactor = val),
                      ),
                      Center(
                        child: FractionallySizedBox(
                          widthFactor: _fractionFactor,
                          child: FilledButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Botón presionado con ancho al ${(_fractionFactor * 100).toInt()}%')),
                              );
                            },
                            icon: const Icon(Icons.check_circle_outline),
                            label: Text('Botón al ${(_fractionFactor * 100).toInt()}% del ancho'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Panel 4: Flexible y Expanded con Flex
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.view_column_rounded, color: Colors.teal),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Flexible y Expanded con Parámetro Flex',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Distribución de espacio proporcional: TextField (flex: $_searchFlex) vs Botón (flex: $_buttonFlex)',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            flex: _searchFlex,
                            child: const TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Buscar reportes o zonas...',
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: _buttonFlex,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () {},
                              child: const Text('Buscar', overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text('Flex 2 : 1'),
                            selected: _searchFlex == 2 && _buttonFlex == 1,
                            onSelected: (_) => setState(() {
                              _searchFlex = 2;
                              _buttonFlex = 1;
                            }),
                          ),
                          ChoiceChip(
                            label: const Text('Flex 3 : 1'),
                            selected: _searchFlex == 3 && _buttonFlex == 1,
                            onSelected: (_) => setState(() {
                              _searchFlex = 3;
                              _buttonFlex = 1;
                            }),
                          ),
                          ChoiceChip(
                            label: const Text('Flex 1 : 1'),
                            selected: _searchFlex == 1 && _buttonFlex == 1,
                            onSelected: (_) => setState(() {
                              _searchFlex = 1;
                              _buttonFlex = 1;
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricChip(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    bool isHighlighted = false,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isHighlighted ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlighted ? theme.colorScheme.primary : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: isHighlighted ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.primary),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isHighlighted ? theme.colorScheme.onPrimaryContainer : Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSampleCard(String title, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
