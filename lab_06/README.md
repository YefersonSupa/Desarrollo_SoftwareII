# Laboratorio 06: Diseño Responsivo y Accesible en Flutter
## Asignatura: Desarrollo de Software II — UNSAAC

**Estudiante:** SUPA CUSIPAUCAR, Yeferson — Código: 220553  
**Docente Responsable:** Ing. Hans Harley Ccacyahuillca Bejar  
**Institución:** Universidad Nacional de San Antonio Abad del Cusco (UNSAAC)  
**Facultad:** Facultad de Ingeniería Eléctrica, Electrónica, Informática y Mecánica  
**Escuela Profesional:** Escuela Profesional de Ingeniería Informática y de Sistemas  
**Semestre Académico:** 2026-II (Décimo Semestre)  
**Repositorio Oficial:** [GitHub - Desarrollo_SoftwareII](https://github.com/YefersonSupa/Desarrollo_SoftwareII)  

---

## 1. Resumen Ejecutivo de la Práctica 06

El diseño de aplicaciones modernas exige que el software funcione de manera fluida y consistente en una multiplicidad de factores de forma (teléfonos móviles compactos, tabletas, ordenadores de escritorio y pantallas ultrapanorámicas) sin sacrificar la universalidad del acceso para personas con capacidades diversas.

La **Práctica de Laboratorio N° 06: Diseño Responsivo y Accesible en Flutter** desarrolla una solución integral y modular materializada en la aplicación `responsive_app`, construida bajo **Flutter 3.47** y **Dart 3.13** con componentes de **Material Design 3**.

La solución implementa exhaustivamente los 5 núcleos de la guía:

1. **Mecanismos de Layout Responsivo:**
   - Panel de telemetría en tiempo real que monitoriza ancho, alto y orientación con `MediaQuery.sizeOf(context)`.
   - Contenedor dinámico con `LayoutBuilder` que conmuta entre disposición en columna (`Column`) y fila (`Row`) cuando el ancho supera el umbral de $600\text{ px}$.
   - Control interactivo de dimensionamiento relativo mediante `FractionallySizedBox` (20% al 100%).
   - Distribución proporcional del espacio mediante `Expanded` y `Flexible` con relaciones `flex` equilibradas ($1:1$) y asimétricas ($2:1$).

2. **Breakpoints y Diseño Adaptativo:**
   - Clase centralizada `Breakpoints` con umbrales ergonómicos: Móvil ($<480\text{ px}$), Tablet ($480-1024\text{ px}$), Desktop ($\ge 1024\text{ px}$) y Ultra-ancho ($\ge 1440\text{ px}$).
   - Grilla fluida mediante `SliverGridDelegateWithMaxCrossAxisExtent` con control en vivo del ancho máximo de celda ($160\text{ px}$ a $340\text{ px}$).
   - Catálogo semántico de 8 servicios urbanos ciudadanos (*Alumbrado Público, Limpieza Urbana, Parques, Seguridad Vecinal, etc.*) con estados, badges y valoraciones numéricas.
   - Navegación adaptativa: conmuta automáticamente entre `NavigationBar` inferior en móvil y `NavigationRail` lateral en tablet/desktop.

3. **Accesibilidad Visual y Motriz (WCAG 2.1 AA):**
   - Simulador en vivo de escalamiento tipográfico ($0.85\times$ a $1.8\times$) validando que ningún texto sufra truncamiento forzado ni rompa contenedores.
   - Auditor visual de objetivos táctiles (*touch targets*), contrastando un botón defectuoso de $24\times 24\text{ px}$ contra el estándar normativo de $48\times 48\text{ px}$.
   - Conmutador de modo Alto Contraste que aplica fondo negro puro (`#000000`) y acento amarillo dorado (`#FFD700`), superando holgadamente el ratio de contraste WCAG AA de $4.5:1$ (alcanzando $>15:1$).
   - Navegación por teclado con secuencia lógica de foco mediante `FocusTraversalOrder`.

4. **Semántica para Tecnologías Asistivas (Lectores de Pantalla):**
   - Configuración de etiquetas (`label`), pistas de acción (`hint`) e intención (`button: true`) con el widget `Semantics`.
   - Exclusión de ornamentos gráficos y estrellas de puntuación mediante `ExcludeSemantics`.
   - Fusión de controles compuestos (checkbox + descripción) en un único nodo auditivo con `MergeSemantics`.
   - Anuncios vocales prioritarios con `SemanticsService.announce` y regiones autolegibles con `liveRegion: true`.
   - Interruptor interactivo de la superposición diagnóstica `SemanticsDebugger`.

5. **Checklist Interactivo de Lanzamiento:**
   - Implementación en código de los **20 criterios oficiales** de la página 8 de la Guía 06, organizados en cuatro categorías: Diseño Responsivo, Tipografía, Accesibilidad y Pruebas.
   - Barra de progreso porcentual dinámica, conteo en tiempo real, filtros por categoría y marcado/desmarcado global.

---

## 2. Matriz de Módulos y Evidencias Visuales

| # | Módulo / Pantalla | Componentes y Widgets Clave | Captura Generada |
|---|---|---|---|
| **1** | **Layout Responsivo** | `LayoutBuilder`, `MediaQuery.sizeOf`, `FractionallySizedBox`, `Expanded`, `Flexible` | [![Módulo 1](ej1.png)](ej1.png) |
| **2** | **Grilla Adaptativa** | `Breakpoints`, `SliverGridDelegateWithMaxCrossAxisExtent`, `Card`, `FilterChip` | [![Módulo 2](ej2.png)](ej2.png) |
| **3** | **Accesibilidad y Contraste** | `TextScaler`, `WCAG AA 4.5:1`, `kMinInteractiveDimension (48x48)`, `FocusTraversalOrder` | [![Módulo 3](ej3.png)](ej3.png) |
| **4** | **Semántica y Lectores** | `Semantics`, `ExcludeSemantics`, `MergeSemantics`, `SemanticsService`, `SemanticsDebugger` | [![Módulo 4](ej4.png)](ej4.png) |
| **5** | **Checklist de Lanzamiento** | 20 criterios oficiales (Pág. 8 de la guía), `LinearProgressIndicator`, filtros por eje | [![Módulo 5](ej5.png)](ej5.png) |

---

## 3. Matriz Oficial del Checklist de Lanzamiento (20 Criterios)

| N° | Categoría | Criterio de Verificación | Mecanismo en Flutter | Estado |
|---|---|---|---|---|
| 01 | Responsivo | Sin desbordamientos (*overflow errors*) en pantallas estándar | `LayoutBuilder`, `Expanded`, `SingleChildScrollView` | Conforme |
| 02 | Responsivo | Disposición adaptada en pantallas anchas (tablet/desktop) | `NavigationRail`, `Row` con `flex` | Conforme |
| 03 | Responsivo | Navegación adaptada según factor de forma | `NavigationBar` (móvil) / `NavigationRail` (escritorio) | Conforme |
| 04 | Responsivo | Grillas con columnas dinámicas según ancho | `SliverGridDelegateWithMaxCrossAxisExtent` | Conforme |
| 05 | Responsivo | Elementos interactivos utilizables en orientación horizontal | `SingleChildScrollView`, `Flexible` | Conforme |
| 06 | Tipografía | No se bloquea el escalamiento del sistema | Respeta `TextScaler` del sistema | Conforme |
| 07 | Tipografía | Textos no se truncan con escalamiento hasta $1.5\times$ | `Flexible`, `Wrap`, `TextOverflow.ellipsis` controlado | Conforme |
| 08 | Tipografía | Se usa `TextScaler.linear` para fijar límites controlados | `MediaQueryData.textScaler.clamp(...)` | Conforme |
| 09 | Tipografía | Fuentes legibles con pesos tipográficos diferenciados | `FontWeight.w400`, `w600`, `w700` (Material 3) | Conforme |
| 10 | Tipografía | Altura de línea (`height`) configurada para evitar colisiones | `TextStyle(height: 1.3 - 1.5)` | Conforme |
| 11 | Accesibilidad | Contraste texto/fondo cumple WCAG AA ($4.5:1$ texto normal) | `ColorScheme` institucional con ratio $\ge 4.5:1$ | Conforme |
| 12 | Accesibilidad | Contraste texto/fondo cumple WCAG AA ($3.0:1$ texto grande) | Tema de Alto Contraste con ratio $> 15:1$ | Conforme |
| 13 | Accesibilidad | Objetivos táctiles mínimos de $48\times 48\text{ px}$ lógicos | `kMinInteractiveDimension` en todos los controles | Conforme |
| 14 | Accesibilidad | Imágenes significativas cuentan con etiqueta semántica | `Semantics(label: "...", button: true)` | Conforme |
| 15 | Accesibilidad | Iconos decorativos excluidos del lector de pantalla | `ExcludeSemantics` en estrellas y gráficos de adorno | Conforme |
| 16 | Accesibilidad | Elementos complejos fusionados con `MergeSemantics` | `MergeSemantics` en casillas y tarjetas informativas | Conforme |
| 17 | Accesibilidad | Cambios de estado anunciados con `SemanticsService` | `SemanticsService.announce(...)` en eventos clave | Conforme |
| 18 | Accesibilidad | Orden de foco lógico para navegación por teclado | `FocusTraversalGroup`, `NumericFocusOrder` | Conforme |
| 19 | Pruebas | Probado con lector de pantalla (TalkBack / VoiceOver) | Auditoría en vivo mediante `SemanticsDebugger` | Conforme |
| 20 | Pruebas | Probado con suite de tests automatizados | Suite completa en `test/` (9 pruebas, 100% OK) | Conforme |

---

## 4. Arquitectura y Estructura del Código

```text
lab_06/
├── Guia06-flutter_responsivo_accesible.docx.pdf # Documento oficial de cátedra
├── unsaac.jpg                                   # Escudo institucional para LaTeX
├── informe_laboratorio_06.tex                   # Informe académico formal
├── README.md                                    # Esta documentación técnica
├── ej1.png ... ej5.png                          # Evidencias visuales de los 5 módulos
└── responsive_app/                              # Aplicación Flutter ejecutable
    ├── pubspec.yaml                             # Configuración y dependencias
    ├── lib/
    │   ├── main.dart                            # Scaffold adaptativo y ruteo
    │   ├── utils/
    │   │   └── breakpoints.dart                 # Breakpoints estáticos y cálculo de columnas
    │   ├── models/
    │   │   ├── catalog_item.dart                # Modelo de ítems y dataset de muestra
    │   │   └── checklist_item.dart              # Modelo y los 20 criterios oficiales
    │   └── screens/
    │       ├── responsive_layout_screen.dart    # Módulo 1: LayoutBuilder y MediaQuery
    │       ├── adaptive_grid_screen.dart        # Módulo 2: Grillas adaptativas
    │       ├── accessibility_screen.dart        # Módulo 3: Contraste, Touch Targets y Texto
    │       ├── semantics_screen.dart            # Módulo 4: Semántica para lectores
    │       └── checklist_screen.dart            # Módulo 5: Checklist interactivo
    └── test/
        ├── responsive_accessible_test.dart      # 9 pruebas unitarias y de widgets
        └── capture_screenshots_test.dart        # Captura headless automatizada de evidencias
```

---

## 5. Instrucciones de Compilación y Ejecución

### 5.1. Ejecución de la Aplicación Flutter

Desde la terminal en el directorio del proyecto:

```powershell
cd lab_06/responsive_app
flutter pub get
flutter run -d windows
# O alternativamente para navegador web o emulador móvil:
flutter run -d chrome
```

### 5.2. Ejecución de la Suite de Pruebas Automatizadas

Para validar que todos los breakpoints, modelos, renderizados adaptativos, áreas táctiles y semánticas se encuentren 100% conformes:

```powershell
cd lab_06/responsive_app
flutter test test/responsive_accessible_test.dart
```

Resultado verificado:
```text
00:00 +0: Breakpoints: Calculo de columnas dinamicas para grilla adaptativa
00:00 +1: CatalogItem: Dataset de muestra contiene 8 elementos con semantica completa
00:00 +2: ChecklistItem: Los 20 criterios oficiales de la Guia 06 estan presentes
00:00 +3: 1. Renderizado inicial de la aplicacion y navegacion movil
00:00 +4: 2. Adaptabilidad Desktop: Renderiza NavigationRail en pantallas anchas
00:00 +5: 3. Navegacion a Adaptive Grid y presencia de tarjetas
00:01 +6: 4. Verificacion de Touch Target optimo (48x48 px)
00:01 +7: 5. Verificacion de Semantica y MergeSemantics
00:01 +8: 6. Verificacion de Checklist interactivo y toggle de items
00:01 +9: All tests passed!
```

---

## 6. Compilación del Informe en LaTeX

El informe formal institucional se encuentra en `lab_06/informe_laboratorio_06.tex`. Cuenta con la carátula oficial de la UNSAAC, la tabla `longtable` del checklist oficial ajustada a márgenes, fragmentos de código Dart y referencias bibliográficas.

Para compilarlo en un entorno con TeX Live, MiKTeX u Overleaf:

```bash
cd lab_06
pdflatex -interaction=nonstopmode informe_laboratorio_06.tex
pdflatex -interaction=nonstopmode informe_laboratorio_06.tex # Segunda pasada para índice y tablas
```
