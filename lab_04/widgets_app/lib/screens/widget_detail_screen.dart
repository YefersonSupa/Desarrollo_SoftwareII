import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/widget_info.dart';

class WidgetDetailScreen extends StatefulWidget {
  final WidgetInfo info;

  const WidgetDetailScreen({super.key, required this.info});

  @override
  State<WidgetDetailScreen> createState() => _WidgetDetailScreenState();
}

class _WidgetDetailScreenState extends State<WidgetDetailScreen> {
  // Estados para Container
  double _containerWidth = 200.0;
  double _containerHeight = 100.0;
  double _containerRadius = 12.0;

  // Estados para ElevatedButton
  int _buttonClicks = 0;

  // Estados para TextField
  final TextEditingController _textCtrl = TextEditingController(text: 'Hola Flutter UNSAAC');

  // Estados para Switch y Checkbox
  bool _switchVal = true;
  bool _checkVal = true;

  // Estados para Dropdown
  String _dropdownVal = 'Opción A';

  // Estados para Slider
  double _sliderVal = 50.0;

  // Estados para ProgressIndicators
  double _simProgress = 0.0;
  bool _isProgressSimulating = false;
  Timer? _progressTimer;

  // Estados para Chips
  final Set<String> _selectedChips = {'Flutter', 'Dart'};
  final List<String> _deletableChips = ['Widget', 'State', 'Context'];

  // Estados para Navigator demo
  String _navReturnResult = '';

  @override
  void initState() {
    super.initState();
    if (widget.info.id == 'progress_indicators') {
      _startProgressSimulation();
    }
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    _textCtrl.dispose();
    super.dispose();
  }

  void _startProgressSimulation() {
    _progressTimer?.cancel();
    setState(() {
      _simProgress = 0.0;
      _isProgressSimulating = true;
    });
    _progressTimer = Timer.periodic(const Duration(milliseconds: 60), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        _simProgress += 0.02;
        if (_simProgress >= 1.0) {
          _simProgress = 1.0;
          _isProgressSimulating = false;
          t.cancel();
        }
      });
    });
  }

  Widget _buildLiveExecutionWidget(String id) {
    switch (id) {
      case 'container':
        return Column(
          children: [
            Container(
              width: _containerWidth,
              height: _containerHeight,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(_containerRadius),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
              ),
              child: const Center(
                child: Text(
                  'Container en Ejecución',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _containerWidth,
                    min: 120,
                    max: 260,
                    onChanged: (v) => setState(() => _containerWidth = v),
                  ),
                ),
                Text('${_containerWidth.toInt()}px ancho'),
              ],
            ),
          ],
        );

      case 'row':
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.star, color: Colors.amber, size: 28),
              Text('Texto en Fila', style: TextStyle(fontWeight: FontWeight.bold)),
              Icon(Icons.favorite, color: Colors.pink, size: 28),
            ],
          ),
        );

      case 'column':
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Text('Título Principal (Eje Y)', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Subtítulo descriptivo en Columna'),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: () {}, child: const Text('Acción en Columna')),
            ],
          ),
        );

      case 'stack':
        return Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(colors: [Colors.indigo, Colors.cyan]),
          ),
          child: Stack(
            children: [
              const Center(child: Icon(Icons.layers, size: 60, color: Colors.white30)),
              const Positioned(
                top: 10,
                left: 10,
                child: Chip(label: Text('Capa Fondo Z: 0', style: TextStyle(fontSize: 11))),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text('Positioned Overlay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );

      case 'expanded_flexible':
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 45,
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text('Expanded (flex: 2)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 45,
                color: Colors.red,
                alignment: Alignment.center,
                child: const Text('flex: 1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        );

      case 'padding_sizedbox':
        return Column(
          children: [
            Container(
              color: Colors.indigo.shade50,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text('Texto con Padding interno aplicado'),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.shade200,
              child: const Text('Separado por SizedBox(height: 16)'),
            ),
          ],
        );

      case 'text':
        return const Text(
          'Texto en Ejecución con TextStyle personalizado, negrita y color índigo.',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo),
          textAlign: TextAlign.center,
        );

      case 'image':
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            'https://picsum.photos/350/150',
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 100,
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Icon(Icons.image, size: 50, color: Colors.grey),
            ),
          ),
        );

      case 'card':
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.credit_card, color: Colors.green),
                SizedBox(width: 8),
                Text('Tarjeta Card con Elevación 4.0', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );

      case 'circle_avatar':
        return const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.purple,
              child: Text('YS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage('https://picsum.photos/100'),
            ),
          ],
        );

      case 'list_view':
        return Container(
          height: 130,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, i) => ListTile(
              dense: true,
              leading: const Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text('Elemento de lista #${i + 1}'),
            ),
          ),
        );

      case 'grid_view':
        return SizedBox(
          height: 110,
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            children: List.generate(
              4,
              (i) => Card(
                color: Colors.green.shade50,
                child: Center(child: Text('Rejilla Celda ${i + 1}', style: const TextStyle(fontWeight: FontWeight.bold))),
              ),
            ),
          ),
        );

      case 'elevated_button':
        return Column(
          children: [
            ElevatedButton.icon(
              onPressed: () => setState(() => _buttonClicks++),
              icon: const Icon(Icons.touch_app),
              label: const Text('Presionar Botón'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFB8C00),
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text('Pulsaciones registradas: $_buttonClicks', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        );

      case 'text_field':
        return Column(
          children: [
            TextField(
              controller: _textCtrl,
              decoration: const InputDecoration(
                labelText: 'Campo de texto en vivo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 6),
            Text('Valor actual: "${_textCtrl.text}"', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
          ],
        );

      case 'switch_checkbox':
        return Column(
          children: [
            SwitchListTile(
              dense: true,
              title: const Text('Switch interactivo'),
              value: _switchVal,
              activeColor: Colors.orange,
              onChanged: (v) => setState(() => _switchVal = v),
            ),
            CheckboxListTile(
              dense: true,
              title: const Text('Checkbox interactivo'),
              value: _checkVal,
              activeColor: Colors.orange,
              onChanged: (v) => setState(() => _checkVal = v ?? false),
            ),
          ],
        );

      case 'dropdown_button':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(border: Border.all(color: Colors.orange), borderRadius: BorderRadius.circular(8)),
          child: DropdownButton<String>(
            value: _dropdownVal,
            isExpanded: true,
            underline: const SizedBox(),
            items: ['Opción A', 'Opción B', 'Opción C']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() => _dropdownVal = v!),
          ),
        );

      case 'slider':
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Valor del Slider:'),
                Text('${_sliderVal.round()}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            Slider(
              value: _sliderVal,
              min: 0,
              max: 100,
              divisions: 10,
              label: '${_sliderVal.round()}%',
              activeColor: Colors.orange,
              onChanged: (v) => setState(() => _sliderVal = v),
            ),
          ],
        );

      case 'app_bar':
        return AppBar(
          title: const Text('Mini AppBar'),
          backgroundColor: const Color(0xFF8E24AA),
          foregroundColor: Colors.white,
          leading: const Icon(Icons.menu),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        );

      case 'bottom_nav_bar':
        return BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: const Color(0xFF8E24AA),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          ],
        );

      case 'tab_bar':
        return DefaultTabController(
          length: 3,
          child: Container(
            height: 120,
            decoration: BoxDecoration(border: Border.all(color: Colors.purple.shade200), borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Container(
                  color: const Color(0xFF8E24AA),
                  child: const TabBar(
                    indicatorColor: Colors.amber,
                    labelColor: Colors.white,
                    tabs: [Tab(text: 'Dart'), Tab(text: 'Flutter'), Tab(text: 'UNSAAC')],
                  ),
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      Center(child: Text('Vista de pestaña Dart')),
                      Center(child: Text('Vista de pestaña Flutter')),
                      Center(child: Text('Vista de pestaña UNSAAC')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );

      case 'navigator_routes':
        return Column(
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                final r = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(title: const Text('Pantalla Pushed'), backgroundColor: const Color(0xFF8E24AA), foregroundColor: Colors.white),
                      body: Center(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context, 'Dato devuelto con pop()'),
                          child: const Text('Regresar con Navigator.pop'),
                        ),
                      ),
                    ),
                  ),
                );
                if (r != null) setState(() => _navReturnResult = r);
              },
              icon: const Icon(Icons.open_in_new),
              label: const Text('Probar Navigator.push'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8E24AA), foregroundColor: Colors.white),
            ),
            if (_navReturnResult.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text('Retorno: $_navReturnResult', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
            ],
          ],
        );

      case 'snack_bar':
        return ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('¡Notificación SnackBar Flotante!'),
                behavior: SnackBarBehavior.floating,
                action: SnackBarAction(label: 'OK', onPressed: () {}),
              ),
            );
          },
          icon: const Icon(Icons.notifications_active),
          label: const Text('Lanzar SnackBar Flotante'),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE53935), foregroundColor: Colors.white),
        );

      case 'progress_indicators':
        return Column(
          children: [
            // Indicadores de Animación Continua activa
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                children: [
                  const Text(
                    '1. Animación Continua Indeterminada (value: null):',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE53935), fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 36,
                        height: 36,
                        child: CircularProgressIndicator(
                          value: null,
                          strokeWidth: 4,
                          color: Color(0xFFE53935),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: const LinearProgressIndicator(
                              value: null,
                              color: Color(0xFFE53935),
                              backgroundColor: Colors.white,
                              minHeight: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Simulación animada progresiva de carga
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '2. Carga Progresiva Animada:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Text(
                        '${(_simProgress * 100).toInt()}%',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE53935)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: CircularProgressIndicator(
                          value: _simProgress,
                          strokeWidth: 4,
                          color: const Color(0xFFE53935),
                          backgroundColor: Colors.red.shade100,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: _simProgress,
                              color: const Color(0xFFE53935),
                              backgroundColor: Colors.red.shade100,
                              minHeight: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _startProgressSimulation,
                    icon: Icon(_isProgressSimulating ? Icons.autorenew : Icons.play_arrow),
                    label: Text(_isProgressSimulating ? 'Cargando datos...' : 'Reiniciar Simulación de Carga'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE53935),
                      foregroundColor: Colors.white,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      case 'alert_dialog':
        return ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Diálogo Modal de Alerta'),
                content: const Text('¿Deseas confirmar la acción seleccionada?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
                  ElevatedButton(onPressed: () => Navigator.pop(ctx), child: const Text('Aceptar')),
                ],
              ),
            );
          },
          icon: const Icon(Icons.warning_amber),
          label: const Text('Mostrar AlertDialog'),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE53935), foregroundColor: Colors.white),
        );

      case 'chip_filter_chip':
        return Column(
          children: [
            Wrap(
              spacing: 6,
              children: ['Flutter', 'Dart', 'Android'].map((tag) {
                final isSel = _selectedChips.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSel,
                  onSelected: (v) {
                    setState(() {
                      if (v) _selectedChips.add(tag);
                      else _selectedChips.remove(tag);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: _deletableChips.map((tag) {
                return Chip(
                  avatar: CircleAvatar(child: Text(tag[0])),
                  label: Text(tag),
                  onDeleted: () => setState(() => _deletableChips.remove(tag)),
                );
              }).toList(),
            ),
          ],
        );

      default:
        return const Center(child: Text('Widget en ejecución'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final info = widget.info;

    return Scaffold(
      appBar: AppBar(
        title: Text(info.name),
        backgroundColor: info.category.color,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner de categoría
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: info.category.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: info.category.color.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: info.category.color,
                  radius: 22,
                  child: Icon(info.icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info.name,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: info.category.color,
                        ),
                      ),
                      Text(
                        'Categoría: ${info.category.displayName}',
                        style: TextStyle(
                          color: info.category.color,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // SECCIÓN DESTACADA: EJECUCIÓN EN VIVO DEL WIDGET EN EL CELULAR
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: info.category.color, width: 2),
              boxShadow: [
                BoxShadow(
                  color: info.category.color.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: info.category.color,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.play_circle_fill, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'WIDGET EN EJECUCIÓN EN VIVO',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildLiveExecutionWidget(info.id),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Descripción
          Text('Descripción Funcional', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(info.description, style: theme.textTheme.bodyMedium?.copyWith(height: 1.3)),
          const SizedBox(height: 16),

          // Propiedades principales
          Text('Propiedades Clave', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: info.properties.map((p) => Chip(
              label: Text(p, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold)),
            )).toList(),
          ),
          const SizedBox(height: 16),

          // Consejo 💡
          Card(
            color: Colors.amber.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.amber.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('💡', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Consejo de uso:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
                        const SizedBox(height: 2),
                        Text(info.tip, style: const TextStyle(color: Colors.black87, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Bloque de código Dart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Código Fuente Dart', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                icon: const Icon(Icons.copy, size: 14),
                label: const Text('Copiar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: info.category.color,
                  foregroundColor: Colors.white,
                  visualDensity: VisualDensity.compact,
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: info.codeSample));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Código copiado al portapapeles'), behavior: SnackBarBehavior.floating),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFF1E1E2E), borderRadius: BorderRadius.circular(8)),
            child: SelectableText(
              info.codeSample,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFFA6E3A1), height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
