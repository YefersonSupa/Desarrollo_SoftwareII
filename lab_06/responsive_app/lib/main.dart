import 'package:flutter/material.dart';
import 'screens/responsive_layout_screen.dart';
import 'screens/adaptive_grid_screen.dart';
import 'screens/accessibility_screen.dart';
import 'screens/semantics_screen.dart';
import 'screens/checklist_screen.dart';
import 'utils/breakpoints.dart';

void main() {
  runApp(const ResponsiveAccessibleApp());
}

class ResponsiveAccessibleApp extends StatefulWidget {
  const ResponsiveAccessibleApp({super.key});

  @override
  State<ResponsiveAccessibleApp> createState() => _ResponsiveAccessibleAppState();
}

class _ResponsiveAccessibleAppState extends State<ResponsiveAccessibleApp> {
  double _textScale = 1.0;
  bool _isHighContrast = false;
  bool _showSemanticsDebugger = false;

  @override
  Widget build(BuildContext context) {
    // Definición de temas estándar y de alto contraste
    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF003366), // Azul institucional UNSAAC
        primary: const Color(0xFF003366),
        secondary: const Color(0xFFCC9900), // Dorado UNSAAC
        brightness: Brightness.light,
      ),
    );

    final highContrastTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(
        primary: Colors.yellowAccent,
        onPrimary: Colors.black,
        surface: Color(0xFF121212),
        onSurface: Colors.white,
        secondary: Colors.cyanAccent,
        onSecondary: Colors.black,
      ),
    );

    return MaterialApp(
      title: 'UNSAAC - Práctica 06 Responsivo & Accesible',
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: _showSemanticsDebugger,
      theme: _isHighContrast ? highContrastTheme : lightTheme,
      builder: (context, child) {
        // Inyectar textScaler dinámico para pruebas de accesibilidad
        final currentScaler = MediaQuery.textScalerOf(context);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: currentScaler.clamp(
              minScaleFactor: _textScale,
              maxScaleFactor: _textScale,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: MainNavigationScaffold(
        textScale: _textScale,
        onTextScaleChanged: (val) => setState(() => _textScale = val),
        isHighContrast: _isHighContrast,
        onHighContrastChanged: (val) => setState(() => _isHighContrast = val),
        showSemanticsDebugger: _showSemanticsDebugger,
        onToggleSemanticsDebugger: (val) => setState(() => _showSemanticsDebugger = val),
      ),
    );
  }
}

class MainNavigationScaffold extends StatefulWidget {
  final double textScale;
  final ValueChanged<double> onTextScaleChanged;
  final bool isHighContrast;
  final ValueChanged<bool> onHighContrastChanged;
  final bool showSemanticsDebugger;
  final ValueChanged<bool> onToggleSemanticsDebugger;

  const MainNavigationScaffold({
    super.key,
    required this.textScale,
    required this.onTextScaleChanged,
    required this.isHighContrast,
    required this.onHighContrastChanged,
    required this.showSemanticsDebugger,
    required this.onToggleSemanticsDebugger,
  });

  @override
  State<MainNavigationScaffold> createState() => _MainNavigationScaffoldState();
}

class _MainNavigationScaffoldState extends State<MainNavigationScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDesktopOrTablet = Breakpoints.isDesktop(context) ||
        (Breakpoints.isTablet(context) && MediaQuery.of(context).orientation == Orientation.landscape);

    final pages = [
      const ResponsiveLayoutScreen(),
      const AdaptiveGridScreen(),
      AccessibilityScreen(
        currentTextScale: widget.textScale,
        onTextScaleChanged: widget.onTextScaleChanged,
        isHighContrast: widget.isHighContrast,
        onHighContrastChanged: widget.onHighContrastChanged,
      ),
      SemanticsScreen(
        showSemanticsDebugger: widget.showSemanticsDebugger,
        onToggleSemanticsDebugger: widget.onToggleSemanticsDebugger,
      ),
      const ChecklistScreen(),
    ];

    const destinations = [
      NavigationDestination(
        icon: Icon(Icons.dashboard_customize_outlined),
        selectedIcon: Icon(Icons.dashboard_customize_rounded),
        label: 'Responsivo',
      ),
      NavigationDestination(
        icon: Icon(Icons.grid_view_outlined),
        selectedIcon: Icon(Icons.grid_view_rounded),
        label: 'Adaptive Grid',
      ),
      NavigationDestination(
        icon: Icon(Icons.accessibility_new_outlined),
        selectedIcon: Icon(Icons.accessibility_new_rounded),
        label: 'Accesibilidad',
      ),
      NavigationDestination(
        icon: Icon(Icons.record_voice_over_outlined),
        selectedIcon: Icon(Icons.record_voice_over_rounded),
        label: 'Semántica',
      ),
      NavigationDestination(
        icon: Icon(Icons.checklist_rtl_outlined),
        selectedIcon: Icon(Icons.checklist_rtl_rounded),
        label: 'Checklist',
      ),
    ];

    const railDestinations = [
      NavigationRailDestination(
        icon: Icon(Icons.dashboard_customize_outlined),
        selectedIcon: Icon(Icons.dashboard_customize_rounded),
        label: Text('Responsivo'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.grid_view_outlined),
        selectedIcon: Icon(Icons.grid_view_rounded),
        label: Text('Adaptive Grid'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.accessibility_new_outlined),
        selectedIcon: Icon(Icons.accessibility_new_rounded),
        label: Text('Accesibilidad'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.record_voice_over_outlined),
        selectedIcon: Icon(Icons.record_voice_over_rounded),
        label: Text('Semántica'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.checklist_rtl_outlined),
        selectedIcon: Icon(Icons.checklist_rtl_rounded),
        label: Text('Checklist'),
      ),
    ];

    return Scaffold(
      body: Row(
        children: [
          // NavigationRail para pantallas anchas (Desktop / Tablet horizontal)
          if (isDesktopOrTablet)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (idx) => setState(() => _selectedIndex = idx),
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Text('06', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              destinations: railDestinations,
            ),
          Expanded(
            child: pages[_selectedIndex],
          ),
        ],
      ),
      // NavigationBar inferior para pantallas móviles
      bottomNavigationBar: isDesktopOrTablet
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (idx) => setState(() => _selectedIndex = idx),
              destinations: destinations,
            ),
    );
  }
}
