# Laboratorio 04: Guía Práctica de Widgets en Flutter
## Asignatura: Desarrollo de Software II — UNSAAC

**Estudiante:** SUPA CUSIPAUCAR, Yeferson — Código: 220553  
**Docente Responsable:** Ing. Hans Harley Ccacyahuillca Bejar  
**Institución:** Universidad Nacional de San Antonio Abad del Cusco (UNSAAC)  
**Facultad:** Facultad de Ingeniería Eléctrica, Electrónica, Informática y Mecánica  
**Escuela Profesional:** Escuela Profesional de Ingeniería Informática y de Sistemas  
**Semestre Académico:** 2026-II (Décimo Semestre)  
**Repositorio Oficial:** [GitHub - Desarrollo_SoftwareII](https://github.com/YefersonSupa/Desarrollo_SoftwareII)  

---

## 1. Resumen de la Práctica 04

En el framework Flutter, la premisa fundamental de diseño es: **"En Flutter, todo es un widget"**. Un widget describe una porción inmutable de la interfaz de usuario: layouts, texto, imágenes, botones, animaciones o configuraciones globales del tema de la aplicación.

En este laboratorio se ha desarrollado una **aplicación completa e interactiva en Flutter (`widgets_app`)** que sirve como catálogo didáctico y entorno de pruebas en vivo (playground) para los **25 widgets clave** organizados en **5 categorías fundamentales**, complementado con un **Decálogo de Buenas Prácticas** y una suite completa de **pruebas automatizadas**.

---

## 2. Catálogo de Widgets Desarrollados

| # | Categoría | Widget | Descripción Funcional | Propiedades Principales |
|---|---|---|---|---|
| 1 | **Layout** | `Container` | Caja multipropósito con padding, margen, decoración y restricciones. | `width`, `height`, `padding`, `margin`, `decoration`, `child` |
| 2 | **Layout** | `Row` | Distribuye hijos horizontalmente en una sola fila. | `mainAxisAlignment`, `crossAxisAlignment`, `children` |
| 3 | **Layout** | `Column` | Distribuye hijos verticalmente en una sola columna. | `mainAxisAlignment`, `crossAxisAlignment`, `mainAxisSize`, `children` |
| 4 | **Layout** | `Stack` | Superpone widgets en capas en el eje Z (útil para overlays). | `alignment`, `fit`, `children`, `Positioned` |
| 5 | **Layout** | `Expanded & Flexible` | Distribuyen el espacio restante disponible usando factores `flex`. | `flex`, `fit`, `child` |
| 6 | **Layout** | `Padding & SizedBox` | Espaciado interno controlado y separador de dimensiones fijas. | `padding`, `width`, `height`, `child` |
| 7 | **Display** | `Text` | Renderizado tipográfico con estilos y control de desbordamiento. | `style`, `maxLines`, `overflow`, `textAlign`, `softWrap` |
| 8 | **Display** | `Image` | Carga de imágenes locales (`asset`), remotas (`network`) o en memoria. | `fit`, `width`, `height`, `alignment`, `color` |
| 9 | **Display** | `Card` | Superficie elevada con sombra material y bordes redondeados. | `elevation`, `shape`, `color`, `child`, `margin` |
| 10 | **Display** | `CircleAvatar` | Avatar circular con imagen de fondo o iniciales de respaldo. | `radius`, `backgroundImage`, `backgroundColor`, `child` |
| 11 | **Display** | `ListView` | Lista desplazable y eficiente en memoria (`ListView.builder`). | `itemCount`, `itemBuilder`, `scrollDirection`, `shrinkWrap` |
| 12 | **Display** | `GridView` | Cuadrícula bidimensional con columnas configurables. | `gridDelegate`, `itemCount`, `itemBuilder`, `shrinkWrap` |
| 13 | **Input** | `ElevatedButton` | Botón material elevado para acciones de jerarquía primaria. | `onPressed`, `style`, `child` |
| 14 | **Input** | `TextField` | Campo de captura de texto con validación y controladores. | `controller`, `decoration`, `keyboardType`, `obscureText`, `onChanged` |
| 15 | **Input** | `Switch & Checkbox` | Controles de alternancia para valores booleanos y preferencias. | `value`, `onChanged`, `activeColor` |
| 16 | **Input** | `DropdownButton` | Menú desplegable para selección tipada de opciones. | `value`, `items`, `onChanged`, `hint`, `isExpanded` |
| 17 | **Input** | `Slider` | Control deslizante continuo o discreto para selección en rango. | `value`, `min`, `max`, `divisions`, `label`, `onChanged` |
| 18 | **Navegación** | `AppBar` | Barra de aplicación superior con título, menú y acciones. | `title`, `leading`, `actions`, `backgroundColor`, `elevation` |
| 19 | **Navegación** | `BottomNavigationBar` | Barra de navegación inferior persistente con múltiples destinos. | `currentIndex`, `onTap`, `items`, `type`, `selectedItemColor` |
| 20 | **Navegación** | `TabBar & TabBarView` | Pestañas horizontales sincronizadas con páginas desplazables. | `tabs`, `controller`, `indicatorColor`, `labelColor` |
| 21 | **Navegación** | `Navigator & Routes` | Pila de navegación entre pantallas (`push`, `pop`, paso de datos). | `push`, `pop`, `pushNamed`, `pushReplacement` |
| 22 | **Feedback** | `SnackBar` | Mensaje emergente inferior flotante con soporte para acciones. | `content`, `duration`, `action`, `backgroundColor`, `behavior` |
| 23 | **Feedback** | `ProgressIndicator` | Indicadores de progreso (circular o lineal; determinado/indeterminado). | `value`, `color`, `strokeWidth`, `backgroundColor` |
| 24 | **Feedback** | `AlertDialog` | Diálogo modal que solicita confirmación o atención del usuario. | `title`, `content`, `actions`, `shape`, `barrierDismissible` |
| 25 | **Feedback** | `Chip & FilterChip` | Etiquetas compactas e interactivas con estados de filtro y borrado. | `label`, `avatar`, `backgroundColor`, `onDeleted`, `selected` |

---

## 3. Estructura de la Aplicación (`widgets_app`)

```text
lab_04/
├── README.md                              # Documentación completa del laboratorio
├── informe_laboratorio_04.tex             # Informe técnico institucional en LaTeX
├── unsaac.jpg                             # Escudo oficial de la UNSAAC
└── widgets_app/                           # Proyecto completo en Flutter
    ├── pubspec.yaml                       # Dependencias y configuración de versión
    ├── lib/
    │   ├── main.dart                      # Punto de entrada, MaterialApp y tema Material 3
    │   ├── models/
    │   │   └── widget_info.dart           # Modelo y categorías de los widgets
    │   ├── data/
    │   │   └── widgets_data.dart          # Base de datos de los 25 widgets y 10 consejos
    │   ├── widgets/
    │   │   └── widget_demo_card.dart      # Componente modular de tarjeta de demostración
    │   └── screens/
    │       ├── home_screen.dart           # Pantalla principal con búsqueda, filtros y métricas
    │       ├── widget_detail_screen.dart  # Ficha técnica individual de widget con copia de código
    │       ├── tips_screen.dart           # Pantalla interactiva con el Decálogo de Buenas Prácticas
    │       └── categories/
    │           ├── layout_screen.dart     # 6 Demos interactivos de Layout
    │           ├── display_screen.dart    # 6 Demos interactivos de Display
    │           ├── input_screen.dart      # 5 Demos interactivos de Input
    │           ├── navigation_screen.dart # 4 Demos interactivos de Navegación
    │           └── feedback_screen.dart   # 4 Demos interactivos de Feedback
    └── test/
        └── widget_test.dart               # Suite de 5 pruebas unitarias y de widgets
```

---

## 4. Instrucciones de Ejecución y Pruebas

### 4.1. Ejecutar la Aplicación en Modo Interactivo
Para iniciar la aplicación en el dispositivo o emulador deseado (Windows, Chrome, Android):

```bash
cd lab_04/widgets_app
flutter run
```

### 4.2. Ejecutar Pruebas Automatizadas
Para verificar que todos los widgets, el árbol de navegación y la base de datos se ejecuten sin errores:

```bash
cd lab_04/widgets_app
flutter test
```

Salida esperada:
```text
00:00 +0: Verificar integridad del dataset de 25 widgets
00:00 +1: Renderizado inicial de la aplicación y cabecera UNSAAC
00:02 +2: Búsqueda reactiva de widgets por texto
00:03 +3: Navegación hacia la pantalla de Layout y regreso
00:04 +4: Alternar modo de tema claro / oscuro
00:04 +5: All tests passed!
```

---

## 5. Decálogo de Buenas Prácticas de Flutter

1. **Todo en Flutter es un widget:** Desde el elemento visual más simple hasta la raíz `MaterialApp`.
2. **Usa `const` siempre que el widget sea inmutable:** Reduce reconstrucciones de renderizado en el Widget Tree.
3. **Prefiere `StatelessWidget` sobre `StatefulWidget`:** A menos que el widget requiera estado interno mutable.
4. **Gestión de estado escalable:** En aplicaciones medianas o grandes, utiliza Riverpod, BLoC o Provider en vez de sobrecargar `setState`.
5. **Widget Inspector de DevTools:** La herramienta esencial para inspeccionar dimensiones, constraints y cajas de renderizado.
6. **Aprovecha Hot Reload (`r`) y Hot Restart (`R`):** Acelera el ciclo de desarrollo manteniendo el estado en milisegundos.
7. **Principio DRY (Don't Repeat Yourself):** Extrae widgets reutilizables en clases separadas en lugar de crear métodos auxiliares.
8. **Diseño Responsivo con `MediaQuery`:** Consulta `MediaQuery.of(context).size` para adaptar layouts a diferentes pantallas.
9. **Ajuste armónico con `FittedBox`:** Escala dinámicamente el contenido para evitar desbordamientos visuales (`overflow`).
10. **Diseño Semántico con `ThemeData` y `ColorScheme`:** Emplea `Theme.of(context).colorScheme` para soporte nativo de modo claro y oscuro.
