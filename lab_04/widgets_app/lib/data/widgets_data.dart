import 'package:flutter/material.dart';
import '../models/widget_info.dart';

const List<WidgetInfo> kWidgetsList = [
  // ==========================================
  // LAYOUT (6 WIDGETS)
  // ==========================================
  WidgetInfo(
    id: 'container',
    name: 'Container',
    category: WidgetCategory.layout,
    description: 'Caja con padding, margen, decoración y restricciones de tamaño.',
    properties: ['width', 'height', 'padding', 'margin', 'decoration', 'child'],
    tip: 'Úsalo para aplicar fondo, bordes redondeados y restricciones de tamaño.',
    codeSample: '''Container(
  width: 200,
  height: 100,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
  child: const Text('Hola'),
)''',
    icon: Icons.check_box_outline_blank,
  ),
  WidgetInfo(
    id: 'row',
    name: 'Row',
    category: WidgetCategory.layout,
    description: 'Alinea sus hijos de forma horizontal en una sola línea.',
    properties: ['mainAxisAlignment', 'crossAxisAlignment', 'children'],
    tip: 'mainAxisAlignment controla el eje horizontal; crossAxisAlignment el vertical.',
    codeSample: '''Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: const [
    Icon(Icons.star),
    Text('Texto'),
    Icon(Icons.favorite),
  ],
)''',
    icon: Icons.view_column_outlined,
  ),
  WidgetInfo(
    id: 'column',
    name: 'Column',
    category: WidgetCategory.layout,
    description: 'Alinea sus hijos de forma vertical en una sola columna.',
    properties: ['mainAxisAlignment', 'crossAxisAlignment', 'mainAxisSize', 'children'],
    tip: 'Usa mainAxisSize: MainAxisSize.min para que la columna ocupe solo lo necesario.',
    codeSample: '''Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Text('Título'),
    const Text('Subtítulo'),
    ElevatedButton(
      onPressed: () {},
      child: const Text('Acción'),
    ),
  ],
)''',
    icon: Icons.table_rows_outlined,
  ),
  WidgetInfo(
    id: 'stack',
    name: 'Stack',
    category: WidgetCategory.layout,
    description: 'Apila widgets superpuestos en el eje Z, útil para overlays y capas.',
    properties: ['alignment', 'fit', 'children'],
    tip: 'Usa Positioned dentro de Stack para ubicar elementos con coordenadas exactas.',
    codeSample: '''Stack(
  children: [
    Image.network('https://picsum.photos/300/180'),
    const Positioned(
      bottom: 8,
      right: 8,
      child: Text('Overlay', style: TextStyle(color: Colors.white)),
    ),
  ],
)''',
    icon: Icons.layers_outlined,
  ),
  WidgetInfo(
    id: 'expanded_flexible',
    name: 'Expanded & Flexible',
    category: WidgetCategory.layout,
    description: 'Distribuyen el espacio restante en Row o Column usando el factor flex.',
    properties: ['flex', 'fit', 'child'],
    tip: 'flex: 2 + flex: 1 significa que el primero toma 2/3 del espacio disponible y el segundo 1/3.',
    codeSample: '''Row(
  children: [
    Expanded(
      flex: 2,
      child: Container(color: Colors.blue, height: 40),
    ),
    Expanded(
      flex: 1,
      child: Container(color: Colors.red, height: 40),
    ),
  ],
)''',
    icon: Icons.compare_arrows,
  ),
  WidgetInfo(
    id: 'padding_sizedbox',
    name: 'Padding & SizedBox',
    category: WidgetCategory.layout,
    description: 'Padding agrega espacio interno; SizedBox define dimensiones fijas o espaciadores.',
    properties: ['padding', 'width', 'height', 'child'],
    tip: 'SizedBox(height: N) es el separador vertical más limpio y eficiente entre widgets.',
    codeSample: '''// Padding interno
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: const Text('Con espacio'),
)

// SizedBox como separadores
const SizedBox(height: 16); // Espacio vertical
const SizedBox(width: 8);   // Espacio horizontal''',
    icon: Icons.space_bar,
  ),

  // ==========================================
  // DISPLAY (6 WIDGETS)
  // ==========================================
  WidgetInfo(
    id: 'text',
    name: 'Text',
    category: WidgetCategory.display,
    description: 'Muestra texto con estilos tipográficos completos y control de desbordamiento.',
    properties: ['style', 'maxLines', 'overflow', 'textAlign', 'softWrap'],
    tip: 'Usa Theme.of(context).textTheme para estilos tipográficos consistentes con el tema global.',
    codeSample: '''Text(
  'Hola Flutter',
  style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.indigo,
  ),
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)''',
    icon: Icons.text_fields,
  ),
  WidgetInfo(
    id: 'image',
    name: 'Image',
    category: WidgetCategory.display,
    description: 'Carga y renderiza imágenes desde red, assets locales o memoria.',
    properties: ['fit', 'width', 'height', 'alignment', 'color'],
    tip: 'BoxFit.cover recorta la imagen para llenar el contenedor sin deformar la relación de aspecto.',
    codeSample: '''// Desde internet
Image.network(
  'https://picsum.photos/300/200',
  fit: BoxFit.cover,
  width: 200,
)

// Desde assets locales
Image.asset('assets/logo.png')''',
    icon: Icons.image_outlined,
  ),
  WidgetInfo(
    id: 'card',
    name: 'Card',
    category: WidgetCategory.display,
    description: 'Superficie elevada con sombra material y esquinas redondeadas.',
    properties: ['elevation', 'shape', 'color', 'child', 'margin'],
    tip: 'Usa elevation: 0 para cards planas en diseños modernos y limpios sin sombras pesadas.',
    codeSample: '''Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: Text('Contenido de la Card'),
  ),
)''',
    icon: Icons.credit_card_outlined,
  ),
  WidgetInfo(
    id: 'circle_avatar',
    name: 'CircleAvatar',
    category: WidgetCategory.display,
    description: 'Muestra un avatar circular con imagen de fondo o iniciales como fallback.',
    properties: ['radius', 'backgroundImage', 'backgroundColor', 'child'],
    tip: 'Si backgroundImage y child coexisten, la imagen cubre el child; el child sirve como fallback.',
    codeSample: '''CircleAvatar(
  radius: 30,
  backgroundImage: const NetworkImage('https://picsum.photos/100'),
  backgroundColor: Colors.purple,
  child: const Text('YS'), // Si no hay imagen o mientras carga
)''',
    icon: Icons.account_circle_outlined,
  ),
  WidgetInfo(
    id: 'list_view',
    name: 'ListView',
    category: WidgetCategory.display,
    description: 'Lista desplazable de widgets, altamente eficiente mediante construcción diferida con builder.',
    properties: ['itemCount', 'itemBuilder', 'scrollDirection', 'shrinkWrap'],
    tip: 'ListView.builder es lazy: solo construye y procesa en memoria los ítems visibles en pantalla.',
    codeSample: '''ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      leading: const Icon(Icons.star),
      title: Text(items[index]),
      trailing: const Icon(Icons.chevron_right),
    );
  },
)''',
    icon: Icons.list_alt,
  ),
  WidgetInfo(
    id: 'grid_view',
    name: 'GridView',
    category: WidgetCategory.display,
    description: 'Muestra widgets en una cuadrícula bidimensional con columnas configurables.',
    properties: ['gridDelegate', 'itemCount', 'itemBuilder', 'shrinkWrap'],
    tip: 'crossAxisCount determina cuántas columnas tiene la grilla vertical.',
    codeSample: '''GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) => Card(
    child: Center(child: Text('Item \$index')),
  ),
)''',
    icon: Icons.grid_view,
  ),

  // ==========================================
  // INPUT (5 WIDGETS)
  // ==========================================
  WidgetInfo(
    id: 'elevated_button',
    name: 'ElevatedButton',
    category: WidgetCategory.input,
    description: 'Botón principal con fondo de color y elevación material para acciones destacadas.',
    properties: ['onPressed', 'style', 'child'],
    tip: 'Si onPressed es null, el botón queda deshabilitado automáticamente con estilo atenuado.',
    codeSample: '''ElevatedButton(
  onPressed: () {
    // Acción a ejecutar al pulsar
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: const Text('Aceptar'),
)''',
    icon: Icons.smart_button_outlined,
  ),
  WidgetInfo(
    id: 'text_field',
    name: 'TextField',
    category: WidgetCategory.input,
    description: 'Campo de entrada de texto interactivo con soporte de decoración, controladores y validación.',
    properties: ['controller', 'decoration', 'keyboardType', 'obscureText', 'onChanged'],
    tip: 'Usa TextEditingController para leer, manipular y limpiar el valor del campo de texto.',
    codeSample: '''TextField(
  controller: _controller,
  decoration: const InputDecoration(
    labelText: 'Correo electrónico',
    hintText: 'usuario@unsaac.edu.pe',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.email),
  ),
  keyboardType: TextInputType.emailAddress,
  onChanged: (val) => setState(() {}),
)''',
    icon: Icons.edit_note_outlined,
  ),
  WidgetInfo(
    id: 'switch_checkbox',
    name: 'Switch & Checkbox',
    category: WidgetCategory.input,
    description: 'Controles para valores booleanos que permiten activar o desactivar opciones y preferencias.',
    properties: ['value', 'onChanged', 'activeColor'],
    tip: 'Siempre almacena y actualiza el estado booleano dentro de setState() o un gestor reactivo.',
    codeSample: '''// Switch interactivo
Switch(
  value: _isOn,
  onChanged: (val) => setState(() => _isOn = val),
)

// Checkbox interactivo
Checkbox(
  value: _checked,
  onChanged: (val) => setState(() => _checked = val!),
)''',
    icon: Icons.toggle_on_outlined,
  ),
  WidgetInfo(
    id: 'dropdown_button',
    name: 'DropdownButton',
    category: WidgetCategory.input,
    description: 'Selector desplegable que permite al usuario escoger un elemento de una lista tipada.',
    properties: ['value', 'items', 'onChanged', 'hint', 'isExpanded'],
    tip: 'Usa isExpanded: true para que el menú desplegable ocupe todo el ancho disponible del contenedor.',
    codeSample: '''DropdownButton<String>(
  value: _selected,
  isExpanded: true,
  items: ['Opción A', 'Opción B', 'Opción C']
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
      .toList(),
  onChanged: (val) => setState(() => _selected = val!),
)''',
    icon: Icons.arrow_drop_down_circle_outlined,
  ),
  WidgetInfo(
    id: 'slider',
    name: 'Slider',
    category: WidgetCategory.input,
    description: 'Control deslizante para seleccionar un valor continuo o discreto dentro de un rango determinado.',
    properties: ['value', 'min', 'max', 'divisions', 'label', 'onChanged'],
    tip: 'divisions divide el slider en pasos discretos; label muestra el valor flotante al arrastrar.',
    codeSample: '''Slider(
  value: _value,
  min: 0.0,
  max: 100.0,
  divisions: 10,
  label: _value.round().toString(),
  onChanged: (val) => setState(() => _value = val),
)''',
    icon: Icons.linear_scale,
  ),

  // ==========================================
  // NAVEGACIÓN (4 WIDGETS)
  // ==========================================
  WidgetInfo(
    id: 'app_bar',
    name: 'AppBar',
    category: WidgetCategory.navigation,
    description: 'Barra superior de la aplicación con soporte para título, acciones, ícono de navegación y elevación.',
    properties: ['title', 'leading', 'actions', 'backgroundColor', 'elevation'],
    tip: 'Usa PreferredSize para cambiar la altura del AppBar o agregar componentes inferiores personalizados.',
    codeSample: '''AppBar(
  title: const Text('Mi App'),
  backgroundColor: Colors.indigo,
  leading: IconButton(
    icon: const Icon(Icons.menu),
    onPressed: () {},
  ),
  actions: [
    IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {},
    ),
  ],
)''',
    icon: Icons.web_asset,
  ),
  WidgetInfo(
    id: 'bottom_nav_bar',
    name: 'BottomNavigationBar',
    category: WidgetCategory.navigation,
    description: 'Barra de navegación inferior con pestañas, íconos y etiquetas para pantallas primarias.',
    properties: ['currentIndex', 'onTap', 'items', 'type', 'selectedItemColor'],
    tip: 'Usa type: BottomNavigationBarType.fixed cuando tengas más de 3 ítems para evitar que se oculten los títulos.',
    codeSample: '''BottomNavigationBar(
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),
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
)''',
    icon: Icons.dock,
  ),
  WidgetInfo(
    id: 'tab_bar',
    name: 'TabBar & TabBarView',
    category: WidgetCategory.navigation,
    description: 'Pestañas horizontales coordinadas con vistas paginadas mediante un controlador de tabs.',
    properties: ['tabs', 'controller', 'indicatorColor', 'labelColor'],
    tip: 'DefaultTabController simplifica la sincronización de pestañas sin necesidad de un controlador explícito.',
    codeSample: '''DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      bottom: const TabBar(
        tabs: [Tab(text: 'A'), Tab(text: 'B'), Tab(text: 'C')],
      ),
    ),
    body: const TabBarView(
      children: [PanelA(), PanelB(), PanelC()],
    ),
  ),
)''',
    icon: Icons.tab,
  ),
  WidgetInfo(
    id: 'navigator_routes',
    name: 'Navigator & Routes',
    category: WidgetCategory.navigation,
    description: 'Sistema de navegación en pila entre pantallas mediante rutas declarativas o imperativas.',
    properties: ['push', 'pop', 'pushNamed', 'pushReplacement'],
    tip: 'pushReplacement elimina la pantalla actual de la pila; es ideal para transiciones de autenticación (Login a Home).',
    codeSample: '''// Navegar hacia una nueva pantalla
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const DetalleScreen()),
);

// Retornar a la pantalla anterior
Navigator.pop(context);

// Navegar con rutas nombradas
Navigator.pushNamed(context, '/detalle');''',
    icon: Icons.alt_route,
  ),

  // ==========================================
  // FEEDBACK (4 WIDGETS)
  // ==========================================
  WidgetInfo(
    id: 'snack_bar',
    name: 'SnackBar',
    category: WidgetCategory.feedback,
    description: 'Notificación emergente temporal y discreta que aparece en la parte inferior de la pantalla.',
    properties: ['content', 'duration', 'action', 'backgroundColor', 'behavior'],
    tip: 'Usa SnackBarBehavior.floating para que la barra flote sobre el contenido con márgenes ergonómicos.',
    codeSample: '''ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text('Guardado correctamente'),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Deshacer',
      onPressed: () {
        // Lógica de reversión
      },
    ),
  ),
);''',
    icon: Icons.chat_bubble_outline,
  ),
  WidgetInfo(
    id: 'progress_indicators',
    name: 'Circular & Linear ProgressIndicator',
    category: WidgetCategory.feedback,
    description: 'Indicadores visuales de progreso en formatos circular o lineal, en estados determinados o indeterminados.',
    properties: ['value', 'color', 'strokeWidth', 'backgroundColor'],
    tip: 'value: null produce una animación giratoria indeterminada; un número de 0.0 a 1.0 refleja el porcentaje exacto.',
    codeSample: '''// Indeterminado (giratorio continuo)
const CircularProgressIndicator(
  color: Colors.indigo,
  strokeWidth: 3,
);

// Determinado (barra con porcentaje exacto)
LinearProgressIndicator(
  value: 0.65, // 65% completado
  backgroundColor: Colors.grey[200],
);''',
    icon: Icons.donut_large,
  ),
  WidgetInfo(
    id: 'alert_dialog',
    name: 'AlertDialog',
    category: WidgetCategory.feedback,
    description: 'Cuadro de diálogo modal que interrumpe la navegación para requerir atención o confirmación del usuario.',
    properties: ['title', 'content', 'actions', 'shape', 'backgroundColor'],
    tip: 'Usa barrierDismissible: false para forzar que el usuario interactúe explícitamente con los botones.',
    codeSample: '''showDialog(
  context: context,
  barrierDismissible: false,
  builder: (_) => AlertDialog(
    title: const Text('Confirmar acción'),
    content: const Text('¿Estás seguro de continuar con el proceso?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: const Text('Cancelar'),
      ),
      ElevatedButton(
        onPressed: () => Navigator.pop(context, true),
        child: const Text('Aceptar'),
      ),
    ],
  ),
);''',
    icon: Icons.warning_amber_rounded,
  ),
  WidgetInfo(
    id: 'chip_filter_chip',
    name: 'Chip & FilterChip',
    category: WidgetCategory.feedback,
    description: 'Etiquetas compactas que representan atributos, filtros o entidades interactivas.',
    properties: ['label', 'avatar', 'backgroundColor', 'onDeleted', 'selected'],
    tip: 'FilterChip y ChoiceChip extienden el Chip base con gestión de estado de selección incorporada.',
    codeSample: '''// Chip informativo con avatar y botón de borrado
Chip(
  label: const Text('Flutter'),
  avatar: const CircleAvatar(child: Text('F')),
  onDeleted: () {},
)

// FilterChip con estado de selección
FilterChip(
  label: const Text('Dart'),
  selected: _selected,
  onSelected: (v) => setState(() => _selected = v),
)''',
    icon: Icons.label_outline,
  ),
];

const List<Map<String, String>> kGeneralTips = [
  {
    'title': 'Todo en Flutter es un Widget',
    'desc': 'Desde un simple Text o un espaciador hasta el MaterialApp y la aplicación completa. Los widgets se anidan formando el Widget Tree.',
    'icon': 'widgets',
  },
  {
    'title': 'Usa const siempre que sea posible',
    'desc': 'Los widgets con const son inmutables en tiempo de compilación; Flutter evita reconstruirlos innecesariamente, maximizando los FPS.',
    'icon': 'speed',
  },
  {
    'title': 'StatelessWidget vs StatefulWidget',
    'desc': 'Prefiere StatelessWidget siempre que la interfaz dependa solo de datos estáticos pasados por constructor. Usa StatefulWidget solo cuando el widget maneje estado interno mutable.',
    'icon': 'layers',
  },
  {
    'title': 'Gestión de Estado Escalable',
    'desc': 'Para apps de mediana a gran escala, adopta gestores desacoplados como Riverpod, Provider o BLoC en lugar de propagar setState profundamente.',
    'icon': 'account_tree',
  },
  {
    'title': 'Widget Inspector de DevTools',
    'desc': 'Es tu herramienta fundamental para explorar la jerarquía visual en vivo, medir restricciones (constraints) y depurar problemas de layout en tiempo real.',
    'icon': 'bug_report',
  },
  {
    'title': 'Hot Reload (r) y Hot Restart (R)',
    'desc': 'Hot Reload inyecta código actualizado preservando el estado de la app en milisegundos. Hot Restart reinicia la máquina virtual Dart y el árbol desde cero.',
    'icon': 'flash_on',
  },
  {
    'title': 'Principio DRY: Extraer Widgets',
    'desc': 'Evita métodos auxiliares que retornan widgets; extrae clases StatelessWidget propias. Esto garantiza un rebuild scoped y optimizaciones de const.',
    'icon': 'auto_awesome',
  },
  {
    'title': 'Diseño Adaptativo con MediaQuery',
    'desc': 'MediaQuery.of(context).size y padding proporcionan las dimensiones reales de pantalla y zonas seguras para interfaces responsivas.',
    'icon': 'devices',
  },
  {
    'title': 'Escalado con FittedBox',
    'desc': 'FittedBox escala o ajusta automáticamente el tamaño de su hijo para que encaje de manera armónica en su contenedor sin desbordamiento (overflow).',
    'icon': 'aspect_ratio',
  },
  {
    'title': 'Paleta Semántica con ColorScheme',
    'desc': 'Usa Theme.of(context).colorScheme y TextTheme para respetar el modo claro/oscuro y garantizar accesibilidad visual coherente.',
    'icon': 'palette',
  },
];
