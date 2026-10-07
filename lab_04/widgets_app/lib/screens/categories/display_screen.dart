import 'package:flutter/material.dart';
import '../../data/widgets_data.dart';
import '../../widgets/widget_demo_card.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  // Estados Text
  double _fontSize = 18.0;
  bool _isBold = true;
  Color _textColor = Colors.indigo;
  int _maxLines = 2;
  TextOverflow _overflow = TextOverflow.ellipsis;

  // Estados Image
  BoxFit _imageFit = BoxFit.cover;

  // Estados Card
  double _cardElevation = 4.0;
  double _cardRadius = 12.0;

  // Estados CircleAvatar
  double _avatarRadius = 32.0;
  bool _showNetworkAvatar = true;

  // Estados ListView
  final List<String> _listItems = ['Widget Tree', 'BuildContext', 'Element Tree', 'RenderObject'];

  // Estados GridView
  int _gridColumns = 2;

  @override
  Widget build(BuildContext context) {
    final widgets = kWidgetsList.where((w) => w.category.name == 'display').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets de Display (6)'),
        backgroundColor: const Color(0xFF43A047),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: const Color(0xFFE8F5E9),
            margin: const EdgeInsets.only(bottom: 16),
            child: const Padding(
              padding: EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(Icons.visibility, color: Color(0xFF43A047), size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Los widgets de Display presentan contenido visual, tipográfico, multimedia y colecciones estructuradas al usuario.',
                      style: TextStyle(color: Color(0xFF1B5E20), fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 1. Text
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'text'),
            controls: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Tamaño fuente: ${_fontSize.toInt()}sp'),
                    const SizedBox(width: 16),
                    FilterChip(
                      label: const Text('Negrita'),
                      selected: _isBold,
                      onSelected: (v) => setState(() => _isBold = v),
                    ),
                    const SizedBox(width: 8),
                    DropdownButton<TextOverflow>(
                      value: _overflow,
                      items: const [
                        DropdownMenuItem(value: TextOverflow.ellipsis, child: Text('ellipsis (...)')),
                        DropdownMenuItem(value: TextOverflow.clip, child: Text('clip')),
                        DropdownMenuItem(value: TextOverflow.fade, child: Text('fade')),
                      ],
                      onChanged: (v) => setState(() => _overflow = v!),
                    ),
                  ],
                ),
                Slider(
                  value: _fontSize,
                  min: 12,
                  max: 28,
                  onChanged: (v) => setState(() => _fontSize = v),
                ),
              ],
            ),
            interactiveDemo: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Flutter transforma radicalmente el desarrollo multiplataforma permitiendo compilar código nativo para Android, iOS, Web y Desktop desde un único código base.',
                style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                  color: _textColor,
                ),
                maxLines: _maxLines,
                overflow: _overflow,
              ),
            ),
          ),

          // 2. Image
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'image'),
            controls: Wrap(
              spacing: 8,
              children: [
                BoxFit.cover,
                BoxFit.contain,
                BoxFit.fill,
                BoxFit.fitWidth,
              ].map((fit) {
                return ChoiceChip(
                  label: Text(fit.name),
                  selected: _imageFit == fit,
                  onSelected: (selected) {
                    if (selected) setState(() => _imageFit = fit);
                  },
                );
              }).toList(),
            ),
            interactiveDemo: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 260,
                height: 140,
                color: Colors.grey.shade200,
                child: Image.network(
                  'https://picsum.photos/400/250',
                  fit: _imageFit,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.indigo.shade50,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image, color: Colors.indigo, size: 40),
                          SizedBox(height: 6),
                          Text('Vista previa de Image Widget'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // 3. Card
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'card'),
            controls: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Elevación: ${_cardElevation.toInt()}'),
                      Slider(
                        value: _cardElevation,
                        min: 0,
                        max: 12,
                        onChanged: (v) => setState(() => _cardElevation = v),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Radio bordes: ${_cardRadius.toInt()}px'),
                      Slider(
                        value: _cardRadius,
                        min: 0,
                        max: 24,
                        onChanged: (v) => setState(() => _cardRadius = v),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            interactiveDemo: Card(
              elevation: _cardElevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_cardRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.credit_card, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Superficie Elevada Card', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Elevación dinámica actual: ${_cardElevation.toStringAsFixed(1)} dp'),
                  ],
                ),
              ),
            ),
          ),

          // 4. CircleAvatar
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'circle_avatar'),
            controls: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Radio: ${_avatarRadius.toInt()}px'),
                Slider(
                  value: _avatarRadius,
                  min: 20,
                  max: 48,
                  onChanged: (v) => setState(() => _avatarRadius = v),
                ),
                FilterChip(
                  label: Text(_showNetworkAvatar ? 'Con imagen' : 'Solo iniciales'),
                  selected: _showNetworkAvatar,
                  onSelected: (v) => setState(() => _showNetworkAvatar = v),
                ),
              ],
            ),
            interactiveDemo: CircleAvatar(
              radius: _avatarRadius,
              backgroundColor: const Color(0xFF6A1B9A),
              backgroundImage: _showNetworkAvatar
                  ? const NetworkImage('https://picsum.photos/100/100')
                  : null,
              child: !_showNetworkAvatar
                  ? const Text(
                      'YS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  : null,
            ),
          ),

          // 5. ListView
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'list_view'),
            controls: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _listItems.add('Elemento nuevo #${_listItems.length + 1}');
                    });
                  },
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Agregar ítem'),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Restablecer lista',
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      _listItems.clear();
                      _listItems.addAll(['Widget Tree', 'BuildContext', 'Element Tree', 'RenderObject']);
                    });
                  },
                ),
              ],
            ),
            interactiveDemo: Container(
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                itemCount: _listItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.green.shade100,
                      child: Text('${index + 1}', style: const TextStyle(fontSize: 12)),
                    ),
                    title: Text(_listItems[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _listItems.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // 6. GridView
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'grid_view'),
            controls: Row(
              children: [
                const Text('Columnas de Grilla:'),
                const SizedBox(width: 12),
                Wrap(
                  spacing: 8,
                  children: [2, 3, 4].map((col) {
                    return ChoiceChip(
                      label: Text('$col col'),
                      selected: _gridColumns == col,
                      onSelected: (selected) {
                        if (selected) setState(() => _gridColumns = col);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            interactiveDemo: SizedBox(
              height: 160,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _gridColumns,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.5,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.green.shade50,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.grid_on, size: 18, color: Colors.green.shade700),
                          const SizedBox(height: 2),
                          Text('Celda $index', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
