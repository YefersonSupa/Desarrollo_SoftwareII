import 'package:flutter/material.dart';
import '../../data/widgets_data.dart';
import '../../widgets/widget_demo_card.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  // Estados para Container
  double _containerWidth = 180.0;
  double _containerHeight = 90.0;
  double _containerRadius = 12.0;
  Color _containerColor = Colors.blue;

  // Estados para Row
  MainAxisAlignment _rowAlignment = MainAxisAlignment.spaceAround;

  // Estados para Column
  CrossAxisAlignment _columnCrossAlign = CrossAxisAlignment.center;
  MainAxisSize _columnMainAxisSize = MainAxisSize.min;

  // Estados para Stack
  double _stackOffsetBottom = 8.0;
  double _stackOffsetRight = 8.0;

  // Estados para Expanded & Flexible
  int _flex1 = 2;
  int _flex2 = 1;

  // Estados para Padding & SizedBox
  double _spacerHeight = 16.0;
  double _innerPadding = 12.0;

  @override
  Widget build(BuildContext context) {
    final widgets = kWidgetsList.where((w) => w.category.name == 'layout').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets de Layout (6)'),
        backgroundColor: const Color(0xFF1E88E5),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner introductorio
          Card(
            color: const Color(0xFFE3F2FD),
            margin: const EdgeInsets.only(bottom: 16),
            child: const Padding(
              padding: EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(Icons.dashboard_customize, color: Color(0xFF1E88E5), size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Los widgets de Layout definen la disposición estructural, dimensional y posicional en el Widget Tree.',
                      style: TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 1. Container
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'container'),
            controls: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('Ancho: ${_containerWidth.toInt()}px | Alto: ${_containerHeight.toInt()}px'),
                    ),
                    Text('Borde: ${_containerRadius.toInt()}px'),
                  ],
                ),
                Slider(
                  value: _containerWidth,
                  min: 100,
                  max: 280,
                  onChanged: (v) => setState(() => _containerWidth = v),
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    Colors.blue,
                    Colors.teal,
                    Colors.deepPurple,
                    Colors.indigo,
                  ].map((color) {
                    return ChoiceChip(
                      label: Text(color == Colors.blue ? 'Azul' : color == Colors.teal ? 'Turquesa' : color == Colors.deepPurple ? 'Púrpura' : 'Índigo'),
                      selected: _containerColor == color,
                      onSelected: (selected) {
                        if (selected) setState(() => _containerColor = color);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            interactiveDemo: Container(
              width: _containerWidth,
              height: _containerHeight,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _containerColor,
                borderRadius: BorderRadius.circular(_containerRadius),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Container Dinámico',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          // 2. Row
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'row'),
            controls: Wrap(
              spacing: 8,
              children: [
                MainAxisAlignment.start,
                MainAxisAlignment.center,
                MainAxisAlignment.end,
                MainAxisAlignment.spaceAround,
                MainAxisAlignment.spaceBetween,
                MainAxisAlignment.spaceEvenly,
              ].map((align) {
                return ChoiceChip(
                  label: Text(align.name),
                  selected: _rowAlignment == align,
                  onSelected: (selected) {
                    if (selected) setState(() => _rowAlignment = align);
                  },
                );
              }).toList(),
            ),
            interactiveDemo: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade300, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: _rowAlignment,
                children: const [
                  Chip(
                    avatar: Icon(Icons.star, color: Colors.amber, size: 18),
                    label: Text('Item 1'),
                  ),
                  Chip(
                    avatar: Icon(Icons.favorite, color: Colors.pink, size: 18),
                    label: Text('Item 2'),
                  ),
                  Chip(
                    avatar: Icon(Icons.thumb_up, color: Colors.blue, size: 18),
                    label: Text('Item 3'),
                  ),
                ],
              ),
            ),
          ),

          // 3. Column
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'column'),
            controls: Row(
              children: [
                Expanded(
                  child: DropdownButton<CrossAxisAlignment>(
                    value: _columnCrossAlign,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: CrossAxisAlignment.start,
                        child: Text('crossAxis: start'),
                      ),
                      DropdownMenuItem(
                        value: CrossAxisAlignment.center,
                        child: Text('crossAxis: center'),
                      ),
                      DropdownMenuItem(
                        value: CrossAxisAlignment.end,
                        child: Text('crossAxis: end'),
                      ),
                    ],
                    onChanged: (v) => setState(() => _columnCrossAlign = v!),
                  ),
                ),
                const SizedBox(width: 12),
                FilterChip(
                  label: Text(_columnMainAxisSize == MainAxisSize.min ? 'mainAxisSize: min' : 'mainAxisSize: max'),
                  selected: _columnMainAxisSize == MainAxisSize.min,
                  onSelected: (v) => setState(() {
                    _columnMainAxisSize = v ? MainAxisSize.min : MainAxisSize.max;
                  }),
                ),
              ],
            ),
            interactiveDemo: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: _columnMainAxisSize,
                crossAxisAlignment: _columnCrossAlign,
                children: [
                  Container(
                    color: Colors.blue.shade100,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: const Text('Elemento A (Cabecera)'),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    color: Colors.blue.shade200,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                    child: const Text('Elemento B (Cuerpo)'),
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.touch_app, size: 16),
                    label: const Text('Elemento C (Botón)'),
                  ),
                ],
              ),
            ),
          ),

          // 4. Stack
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'stack'),
            controls: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bottom: ${_stackOffsetBottom.toInt()}px'),
                      Slider(
                        value: _stackOffsetBottom,
                        min: 0,
                        max: 60,
                        onChanged: (v) => setState(() => _stackOffsetBottom = v),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Right: ${_stackOffsetRight.toInt()}px'),
                      Slider(
                        value: _stackOffsetRight,
                        min: 0,
                        max: 100,
                        onChanged: (v) => setState(() => _stackOffsetRight = v),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            interactiveDemo: Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.landscape, size: 80, color: Colors.white30),
                  ),
                  const Positioned(
                    top: 12,
                    left: 12,
                    child: Chip(
                      label: Text('Capa Fondo (Z: 0)', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                  Positioned(
                    bottom: _stackOffsetBottom,
                    right: _stackOffsetRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(color: Colors.black45, blurRadius: 4),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Positioned Overlay',
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 5. Expanded & Flexible
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'expanded_flexible'),
            controls: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Flex Izq: $_flex1'),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: _flex1 > 1 ? () => setState(() => _flex1--) : null,
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: _flex1 < 4 ? () => setState(() => _flex1++) : null,
                ),
                const SizedBox(width: 16),
                Text('Flex Der: $_flex2'),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: _flex2 > 1 ? () => setState(() => _flex2--) : null,
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: _flex2 < 4 ? () => setState(() => _flex2++) : null,
                ),
              ],
            ),
            interactiveDemo: Row(
              children: [
                Expanded(
                  flex: _flex1,
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Flex $_flex1 (${((_flex1 / (_flex1 + _flex2)) * 100).toStringAsFixed(0)}%)',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: _flex2,
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Flex $_flex2 (${((_flex2 / (_flex1 + _flex2)) * 100).toStringAsFixed(0)}%)',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 6. Padding & SizedBox
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'padding_sizedbox'),
            controls: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Padding interno: ${_innerPadding.toInt()}px'),
                Slider(
                  value: _innerPadding,
                  min: 4,
                  max: 28,
                  onChanged: (v) => setState(() => _innerPadding = v),
                ),
                Text('SizedBox espaciador: ${_spacerHeight.toInt()}px'),
                Slider(
                  value: _spacerHeight,
                  min: 4,
                  max: 40,
                  onChanged: (v) => setState(() => _spacerHeight = v),
                ),
              ],
            ),
            interactiveDemo: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    color: Colors.indigo.shade50,
                    child: Padding(
                      padding: EdgeInsets.all(_innerPadding),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        color: Colors.indigo.shade200,
                        child: const Text('Bloque con Padding interno'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _spacerHeight,
                    child: Center(
                      child: Container(
                        height: 2,
                        color: Colors.amber.shade700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.grey.shade200,
                    child: Text('Separado por SizedBox(height: ${_spacerHeight.toInt()})'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
