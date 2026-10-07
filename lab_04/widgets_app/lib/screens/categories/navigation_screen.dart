import 'package:flutter/material.dart';
import '../../data/widgets_data.dart';
import '../../widgets/widget_demo_card.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // Estados AppBar Demo
  int _appBarActionsCount = 2;
  String _simulatedTitle = 'Panel Principal';

  // Estados BottomNavigationBar Demo
  int _bottomNavIndex = 0;

  // Estados Navigator Demo
  String _navigatorResult = 'Ninguno todavía';

  @override
  Widget build(BuildContext context) {
    final widgets = kWidgetsList.where((w) => w.category.name == 'navigation').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets de Navegación (4)'),
        backgroundColor: const Color(0xFF8E24AA),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: const Color(0xFFF3E5F5),
            margin: const EdgeInsets.only(bottom: 16),
            child: const Padding(
              padding: EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(Icons.navigation, color: Color(0xFF8E24AA), size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Los widgets de Navegación organizan el flujo de pantallas, barras de herramientas, tabs y la pila de rutas (Navigator Stack).',
                      style: TextStyle(color: Color(0xFF4A148C), fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 1. AppBar
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'app_bar'),
            controls: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Cambiar Título AppBar',
                      isDense: true,
                    ),
                    onChanged: (v) => setState(() => _simulatedTitle = v.isEmpty ? 'Panel' : v),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Agregar acción',
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: _appBarActionsCount < 4 ? () => setState(() => _appBarActionsCount++) : null,
                ),
                IconButton(
                  tooltip: 'Quitar acción',
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: _appBarActionsCount > 1 ? () => setState(() => _appBarActionsCount--) : null,
                ),
              ],
            ),
            interactiveDemo: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: AppBar(
                title: Text(_simulatedTitle),
                backgroundColor: const Color(0xFF8E24AA),
                foregroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {},
                ),
                actions: [
                  if (_appBarActionsCount >= 1)
                    IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                  if (_appBarActionsCount >= 2)
                    IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
                  if (_appBarActionsCount >= 3)
                    IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
                  if (_appBarActionsCount >= 4)
                    IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
                ],
              ),
            ),
          ),

          // 2. BottomNavigationBar
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'bottom_nav_bar'),
            interactiveDemo: Column(
              children: [
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _bottomNavIndex == 0
                        ? 'Pantalla: 🏠 Inicio'
                        : _bottomNavIndex == 1
                            ? 'Pantalla: 🔍 Buscar'
                            : 'Pantalla: 👤 Perfil de Estudiante',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8),
                BottomNavigationBar(
                  currentIndex: _bottomNavIndex,
                  selectedItemColor: const Color(0xFF8E24AA),
                  onTap: (i) => setState(() => _bottomNavIndex = i),
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Inicio',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Buscar',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Perfil',
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 3. TabBar & TabBarView
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'tab_bar'),
            interactiveDemo: Container(
              height: 190,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Container(
                      color: const Color(0xFF8E24AA),
                      child: const TabBar(
                        indicatorColor: Colors.amber,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white70,
                        tabs: [
                          Tab(icon: Icon(Icons.code), text: 'Dart'),
                          Tab(icon: Icon(Icons.flutter_dash), text: 'Flutter'),
                          Tab(icon: Icon(Icons.school), text: 'UNSAAC'),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          Center(
                            child: Text(
                              'Dart: Lenguaje moderno y fuertemente tipado.',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Flutter: Framework declarativo multiplataforma.',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: Text(
                              'UNSAAC: Laboratorio de Desarrollo de Software II.',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 4. Navigator & Routes
          WidgetDemoCard(
            info: widgets.firstWhere((w) => w.id == 'navigator_routes'),
            interactiveDemo: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final resultado = await Navigator.push<String>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PantallaDetalleDemo(titulo: 'Pantalla de Detalle Empujada (Pushed)'),
                      ),
                    );

                    if (resultado != null) {
                      setState(() {
                        _navigatorResult = resultado;
                      });
                    }
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Abrir Pantalla con Navigator.push'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8E24AA),
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Resultado devuelto con Navigator.pop: "$_navigatorResult"',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PantallaDetalleDemo extends StatelessWidget {
  final String titulo;

  const PantallaDetalleDemo({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        backgroundColor: const Color(0xFF8E24AA),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline, size: 70, color: Color(0xFF8E24AA)),
              const SizedBox(height: 16),
              const Text(
                '¡Navegación en Pila Exitosa!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Esta pantalla fue montada mediante MaterialPageRoute encima de la ruta anterior. Ahora puedes retornar datos usando Navigator.pop(context, valor).',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context, 'Confirmado por usuario desde Detalle (200 OK)');
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Retornar con Dato de Confirmación'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E24AA),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
