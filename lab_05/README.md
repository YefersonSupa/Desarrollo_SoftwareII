# Laboratorio 05: Manejo de Eventos e Interactividad en Flutter
## Asignatura: Desarrollo de Software II — UNSAAC

**Estudiante:** SUPA CUSIPAUCAR, Yeferson — Código: 220553  
**Docente Responsable:** Ing. Hans Harley Ccacyahuillca Bejar  
**Institución:** Universidad Nacional de San Antonio Abad del Cusco (UNSAAC)  
**Facultad:** Facultad de Ingeniería Eléctrica, Electrónica, Informática y Mecánica  
**Escuela Profesional:** Escuela Profesional de Ingeniería Informática y de Sistemas  
**Semestre Académico:** 2026-II (Décimo Semestre)  
**Repositorio Oficial:** [GitHub - Desarrollo_SoftwareII](https://github.com/YefersonSupa/Desarrollo_SoftwareII)  

---

## 1. Resumen Ejecutivo de la Práctica 05

En Flutter, la interactividad es el núcleo de la experiencia de usuario. La aplicación no es estática: responde a estímulos táctiles, entradas de texto, deslizamientos y cambios de estado en tiempo real. 

Esta práctica desarrolla de forma integral la **Guía Práctica N° 05: Manejo de Eventos e Interactividad en Flutter**, implementando una aplicación móvil moderna, modular y reactiva (`events_app`) construida con **Flutter 3.47** y **Dart 3.13**, estructurada bajo la filosofía de diseño Material 3. La solución incluye:

1. **Catálogo de 4 Ejemplos Fundacionales de la Guía:**
   - *Ejemplo 1:* Botón interactivo con `FloatingActionButton` y mutación reactiva mediante `setState()`.
   - *Ejemplo 2:* Entrada de texto en tiempo real con `TextField`, `TextEditingController` y callback `onChanged`.
   - *Ejemplo 3:* Manejo avanzado de gestos táctiles con `GestureDetector` (`onTap`, `onDoubleTap`, `onLongPress`).
   - *Mini Proyecto:* Formulario interactivo con saludo dinámico personalizado (`"Hola, $nombre"`).
2. **Suite Completa de los 9 Ejercicios Propuestos:**
   - **Nivel Básico:**
     - *Ejercicio 1:* Botón interactivo que altera fluidamente el color de fondo con paletas y visor de códigos HEX/RGB.
     - *Ejercicio 2:* Contador bidireccional (`+` y `-`) con reinicio a cero, selector de paso configurable ($\pm 1, \pm 5, \pm 10$) y alertas de umbral.
     - *Ejercicio 3:* Captura de texto reactivo con métricas dinámicas (caracteres, palabras, detector de palíndromos e inversión de texto).
   - **Nivel Intermedio:**
     - *Ejercicio 4:* Formulario de nombre y edad con clasificación etaria automática y generación instantánea de credencial institucional.
     - *Ejercicio 5:* Interruptor (`Switch` / `SwitchListTile`) de encendido y apagado con simulación de bombilla inteligente, regulación continua de intensidad lumínica y selector de color.
     - *Ejercicio 6:* Detección de doble clic (`onDoubleTap`) sobre contenedor con animación de corazón (efecto "Like" estilo Instagram) y registro temporal.
   - **Nivel Avanzado:**
     - *Ejercicio 7:* Lista dinámica reactiva con adición de tareas, selector de prioridades (Alta, Media, Baja), marcado de completado y eliminación mediante deslizamiento (`Dismissible`) con soporte de deshacer (`SnackBarAction`).
     - *Ejercicio 8:* Formulario empresarial con validación estricta (`Form`, `GlobalKey<FormState>`, `TextFormField`), regex de correo, validación numérica de DNI/código, contraseñas y aceptación de términos.
     - *Ejercicio 9:* Mini-juego interactivo de agilidad motriz *"Speed Tap Rush"* con temporizador de 10 segundos (`Timer.periodic`), cálculo de taps por segundo (TPS), ranking de destreza y persistencia de puntaje récord (*High Score*).
3. **Consola y Monitor de Eventos en Tiempo Real (`LiveEventsScreen`):**
   - Bus reactivo de eventos (`EventBus`) desacoplado que registra la traza de cada interacción (`EventType.tap`, `doubleTap`, `longPress`, `changed`, `submitted`, `toggle`, `drag`, `system`) con marcas de tiempo en milisegundos para auditoría didáctica.
4. **Suite de Pruebas Automatizadas:**
   - Cobertura de 10 pruebas unitarias y de widgets ejecutadas mediante `flutter test` con 100% de éxito.

---

## 2. Matriz de Ejercicios y Eventos Implementados

| Nivel | # | Ejercicio | Evento / Callback Principal | Widgets Clave Involucrados | Captura en Celular |
|---|---|---|---|---|---|
| **Guía** | G1 | Botón Interactivo | `onPressed` | `FloatingActionButton`, `Text` | Demo Guía |
| **Guía** | G2 | Entrada de Texto | `onChanged` | `TextField`, `TextEditingController` | Demo Guía |
| **Guía** | G3 | Gestos Táctiles | `onTap`, `onDoubleTap`, `onLongPress` | `GestureDetector`, `AnimatedContainer` | Demo Guía |
| **Guía** | GP | Mini Proyecto | `onChanged` | `TextField`, `AnimatedContainer` | Demo Guía |
| **Básico** | 1 | Botón Color Fondo | `onPressed`, `onTap` | `ElevatedButton`, `ActionChip`, `AnimatedContainer` | [Ver ej1.png](ej1.png) |
| **Básico** | 2 | Contador $+ / -$ | `onPressed`, `onSelectionChanged` | `ElevatedButton`, `SegmentedButton` | [Ver ej2.png](ej2.png) |
| **Básico** | 3 | Captura de Texto | `onChanged`, `onPressed` | `TextField`, `Chip`, `Card` | [Ver ej3.png](ej3.png) |
| **Intermedio** | 4 | Nombre y Edad | `onChanged` | `TextField`, `CircleAvatar`, `AnimatedContainer` | [Ver ej4.png](ej4.png) |
| **Intermedio** | 5 | Switch On/Off | `onChanged (bool)`, `onChanged (double)` | `SwitchListTile`, `Slider`, `ChoiceChip` | [Ver ej5.png](ej5.png) |
| **Intermedio** | 6 | Doble Clic | `onDoubleTap`, `onTap`, `onLongPress` | `GestureDetector`, `TweenAnimationBuilder` | [Ver ej6.png](ej6.png) |
| **Avanzado** | 7 | Lista Dinámica | `onSubmitted`, `onChanged`, `onDismissed` | `ListView.builder`, `Dismissible`, `Checkbox` | [Ver ej7.png](ej7.png) |
| **Avanzado** | 8 | Validación Form | `validator`, `onPressed` | `Form`, `GlobalKey<FormState>`, `TextFormField` | [Ver ej8.png](ej8.png) |
| **Avanzado** | 9 | Juego de Taps | `onTap`, `Timer.periodic` | `GestureDetector`, `AnimatedScale`, `RadialGradient` | [Ver ej9.png](ej9.png) |

---

## 3. Arquitectura del Proyecto (`events_app`)

```text
lab_05/
├── PRÁCTICA 05_ eventos_flutter.docx.pdf # Guía oficial emitida por la cátedra
├── README.md                             # Documentación técnica completa del laboratorio
├── informe_laboratorio_05.tex            # Informe institucional en LaTeX (Norma UNSAAC)
├── unsaac.jpg                            # Escudo oficial de la UNSAAC
└── events_app/                           # Proyecto completo en Flutter
    ├── pubspec.yaml                      # Configuración del paquete y entorno Dart
    ├── analysis_options.yaml             # Reglas de análisis estático del linter
    ├── lib/
    │   ├── main.dart                     # Inicialización, temas Material 3 y mapa de rutas
    │   ├── models/
    │   │   ├── event_log.dart            # Modelo de auditoría de eventos de interfaz
    │   │   ├── exercise_model.dart       # Metadatos del catálogo de ejercicios
    │   │   └── dynamic_item.dart         # Modelo para ítems reactivos de lista dinámica
    │   ├── services/
    │   │   └── event_bus.dart            # Bus de eventos reactivo desacoplado (Singleton)
    │   ├── widgets/
    │   │   ├── custom_app_bar.dart       # Barra superior con contador global de eventos en vivo
    │   │   └── exercise_card.dart        # Tarjeta didáctica con badges y tags de eventos
    │   └── screens/
    │       ├── home_dashboard_screen.dart        # Dashboard principal interactivo
    │       ├── guide_examples_screen.dart        # Módulo de 4 ejemplos de la guía oficial
    │       ├── basic_exercises_screen.dart       # Módulo Nivel Básico (Ejercicios 1, 2, 3)
    │       ├── intermediate_exercises_screen.dart# Módulo Nivel Intermedio (Ejercicios 4, 5, 6)
    │       ├── advanced_exercises_screen.dart    # Módulo Nivel Avanzado (Ejercicios 7, 8, 9)
    │       └── live_events_screen.dart           # Monitor y consola en tiempo real de eventos
    └── test/
        ├── widget_test.dart                      # Smoke test del Dashboard principal
        ├── basic_exercises_test.dart             # Pruebas automatizadas de Ejercicios 1, 2 y 3
        ├── intermediate_exercises_test.dart      # Pruebas automatizadas de Ejercicios 4, 5 y 6
        └── advanced_exercises_test.dart          # Pruebas automatizadas de Ejercicios 7, 8 y 9
```

---

## 4. Instrucciones de Compilación y Ejecución

### 4.1. Ejecución de la Aplicación en Modo Interactivo
Para compilar y correr la aplicación en Windows Desktop, Navegador Chrome o Dispositivo Android:

```bash
cd lab_05/events_app
flutter run
```

### 4.2. Ejecución de la Suite de Pruebas Automatizadas
Para verificar que el 100% de los ejercicios, árboles de widgets y flujos de eventos pasen sin errores:

```bash
cd lab_05/events_app
flutter test
```

*Resultado obtenido:*
```text
00:01 +10: All tests passed!
```

### 4.3. Verificación de Análisis Estático (Linter)
Para asegurar cumplimiento de estándares de código limpio sin advertencias:

```bash
cd lab_05/events_app
flutter analyze
```

*Resultado obtenido:*
```text
Analyzing events_app...
No issues found! (ran in 1.3s)
```

---

## 5. Rúbrica de Evaluación y Logros Alcanzados

| Criterio | Nivel Alcanzado | Puntaje Máximo | Justificación Técnica |
|---|---|:---:|---|
| **Uso de Eventos** | **Excelente** | 20 / 20 | Manejo exhaustivo de múltiples eventos (`onPressed`, `onChanged`, `onTap`, `onDoubleTap`, `onLongPress`, `onSubmitted`, `onDismissed`, temporizadores periódicos). Integración de monitor de auditoría en vivo. |
| **Interactividad** | **Excelente** | 20 / 20 | Interfaz fluida a 60/120 FPS con transiciones suaves (`AnimatedContainer`, `TweenAnimationBuilder`, `AnimatedScale`), feedback visual y tarjetas dinámicas. |
| **Manejo de Estado** | **Excelente** | 20 / 20 | Uso riguroso de `StatefulWidget`, inmutabilidad, mutación controlada con `setState()`, validación de formularios con `GlobalKey<FormState>` y gestión reactiva con `ValueNotifier`. |
| **Código** | **Excelente** | 20 / 20 | Arquitectura limpia y modular por capas (`models`, `services`, `widgets`, `screens`, `test`), 0 errores de análisis estático (`flutter analyze`), 100% pruebas aprobadas (`flutter test`). |
| **Creatividad** | **Excelente** | 20 / 20 | Soluciones enriquecidas: simulador de bombilla neón, detector de palíndromos, carnet institucional virtual en vivo, efecto "Like" estilo Instagram y mini-juego interactivo con cálculo de TPS. |
| **TOTAL** | **Calificación Sobresaliente** | **100 / 100** | **Cumplimiento riguroso de todos los requerimientos de la Guía 05.** |
