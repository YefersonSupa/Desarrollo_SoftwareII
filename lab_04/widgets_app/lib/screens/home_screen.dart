import 'package:flutter/material.dart';
import '../data/widgets_data.dart';
import '../models/widget_info.dart';
import 'categories/layout_screen.dart';
import 'categories/display_screen.dart';
import 'categories/input_screen.dart';
import 'categories/navigation_screen.dart';
import 'categories/feedback_screen.dart';
import 'tips_screen.dart';
import 'widget_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  WidgetCategory? _selectedCategoryFilter;

  void _navigateToCategory(WidgetCategory category) {
    Widget targetScreen;
    switch (category) {
      case WidgetCategory.layout:
        targetScreen = const LayoutScreen();
        break;
      case WidgetCategory.display:
        targetScreen = const DisplayScreen();
        break;
      case WidgetCategory.input:
        targetScreen = const InputScreen();
        break;
      case WidgetCategory.navigation:
        targetScreen = const NavigationScreen();
        break;
      case WidgetCategory.feedback:
        targetScreen = const FeedbackScreen();
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => targetScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Filtrado de widgets
    final filteredWidgets = kWidgetsList.where((w) {
      final matchesQuery = _searchQuery.isEmpty ||
          w.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          w.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          w.properties.any((p) => p.toLowerCase().contains(_searchQuery.toLowerCase()));

      final matchesCategory =
          _selectedCategoryFilter == null || w.category == _selectedCategoryFilter;

      return matchesQuery && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guía Práctica de Widgets en Flutter'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        actions: [
          IconButton(
            tooltip: widget.isDarkMode ? 'Cambiar a modo claro' : 'Cambiar a modo oscuro',
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
          IconButton(
            tooltip: 'Consejos de Flutter',
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TipsScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner Institucional UNSAAC
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.school, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'UNSAAC • INGENIERÍA INFORMÁTICA Y DE SISTEMAS',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                            ),
                          ),
                          Text(
                            'Desarrollo de Software II — Práctica 04',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(color: Colors.white24, height: 1),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Desarrollador: Yeferson Supa (220553)',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Semestre 2026-II',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Tarjetas de Métricas Rápidas
          Row(
            children: [
              _buildMetricChip(
                context,
                title: 'Widgets',
                value: '25',
                color: Colors.indigo,
                icon: Icons.widgets,
              ),
              const SizedBox(width: 8),
              _buildMetricChip(
                context,
                title: 'Categorías',
                value: '5',
                color: Colors.teal,
                icon: Icons.category,
              ),
              const SizedBox(width: 8),
              _buildMetricChip(
                context,
                title: 'Material Design',
                value: 'v3.0',
                color: Colors.deepPurple,
                icon: Icons.design_services,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Barra de Búsqueda
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar widget por nombre, propiedad o uso...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
            ),
            onChanged: (val) => setState(() => _searchQuery = val),
          ),
          const SizedBox(height: 12),

          // Filtro por Categorías
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: const Text('Todos (25)'),
                  selected: _selectedCategoryFilter == null,
                  onSelected: (v) => setState(() => _selectedCategoryFilter = null),
                ),
                const SizedBox(width: 6),
                ...WidgetCategory.values.map((cat) {
                  final count = kWidgetsList.where((w) => w.category == cat).length;
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: FilterChip(
                      avatar: Icon(cat.icon, size: 16, color: cat.color),
                      label: Text('${cat.displayName} ($count)'),
                      selected: _selectedCategoryFilter == cat,
                      selectedColor: cat.color.withOpacity(0.2),
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategoryFilter = selected ? cat : null;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Si el usuario está buscando o filtrando, mostrar lista de resultados directos
          if (_searchQuery.isNotEmpty || _selectedCategoryFilter != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Resultados coincidentes (${filteredWidgets.length}):',
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                      _selectedCategoryFilter = null;
                    });
                  },
                  child: const Text('Ver categorías'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...filteredWidgets.map((w) {
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: w.category.color,
                    child: Icon(w.icon, color: Colors.white, size: 20),
                  ),
                  title: Text(w.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(w.description, maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => WidgetDetailScreen(info: w)),
                    );
                  },
                ),
              );
            }),
          ] else ...[
            // Si no hay búsqueda activa, mostrar las 5 tarjetas de Categorías Principales
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categorías de la Guía',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.school, size: 16),
                  label: const Text('Decálogo'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TipsScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),

            _buildCategoryNavCard(
              context,
              category: WidgetCategory.layout,
              title: '1. Layout (Organización Espacial)',
              count: 6,
              desc: 'Container, Row, Column, Stack, Expanded & Flexible, Padding & SizedBox.',
            ),
            _buildCategoryNavCard(
              context,
              category: WidgetCategory.display,
              title: '2. Display (Presentación de Datos)',
              count: 6,
              desc: 'Text, Image, Card, CircleAvatar, ListView, GridView.',
            ),
            _buildCategoryNavCard(
              context,
              category: WidgetCategory.input,
              title: '3. Input (Captura de Entrada)',
              count: 5,
              desc: 'ElevatedButton, TextField, Switch & Checkbox, DropdownButton, Slider.',
            ),
            _buildCategoryNavCard(
              context,
              category: WidgetCategory.navigation,
              title: '4. Navegación (Flujo entre Pantallas)',
              count: 4,
              desc: 'AppBar, BottomNavigationBar, TabBar, Navigator & Routes.',
            ),
            _buildCategoryNavCard(
              context,
              category: WidgetCategory.feedback,
              title: '5. Feedback (Notificaciones y Estados)',
              count: 4,
              desc: 'SnackBar, Progress Indicators, AlertDialog, Chip & FilterChip.',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMetricChip(
    BuildContext context, {
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryNavCard(
    BuildContext context, {
    required WidgetCategory category,
    required String title,
    required int count,
    required String desc,
  }) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: category.color.withOpacity(0.3)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _navigateToCategory(category),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: category.color.withOpacity(0.15),
                child: Icon(category.icon, color: category.color, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: category.color,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: category.color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$count widgets',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      desc,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios, size: 16, color: category.color),
            ],
          ),
        ),
      ),
    );
  }
}
