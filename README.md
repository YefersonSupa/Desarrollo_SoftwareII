# Desarrollo de Software II

**Universidad Nacional de San Antonio Abad del Cusco (UNSAAC)**  
**Facultad de Ingeniería Eléctrica, Electrónica, Informática y Mecánica**  
**Escuela Profesional de Ingeniería Informática y de Sistemas**  

* **Asignatura:** Desarrollo de Software II (Desarrollo de Aplicaciones Móviles)
* **Semestre Académico:** 2026-I
* **Docente Responsable:** Ing. CCACYAHUILLCA-BEJAR-HANS HARLEY
* **Estudiante:** SUPA CUSIPAUCAR, Yeferson (Código: 220553)
* **Repositorio Oficial:** [https://github.com/YefersonSupa/Desarrollo_SoftwareII](https://github.com/YefersonSupa/Desarrollo_SoftwareII)

---

## 🎯 Índice del Repositorio

1. [Práctica 02: Tipos de Datos en Dart (List, Map, Set y más)](#-práctica-02-tipos-de-datos-en-dart-map-list-set-y-más)
   * [Enlace a DartPad y Ejecución](#-ejecución-en-línea-dartpad)
   * [Estructura de Ejercicios y Código Fuente](#-estructura-de-la-práctica-02)
   * [Pruebas Unitarias Automatizadas](#-pruebas-unitarias-lab_02_testdart)
   * [Informe Académico y Capturas](#-informe-académico-de-respaldo)
2. [Práctica 01: Configuración de Entorno y Hola Mundo Móvil](#-práctica-01-configuración-de-flutter-y-hola-mundo-móvil)
3. [Estructura General del Proyecto](#-estructura-del-directorio)

---

## 🚀 Práctica 02: Tipos de Datos en Dart (Map, List, Set y más)

Esta práctica implementa la solución a los 3 problemas propuestos en la guía de laboratorio oficial (`lab_02/guia02_dart.pdf`), demostrando el dominio de estructuras de datos nativas de Dart, *Null Safety* estricto y optimización de complejidad temporal y espacial (Nivel Excelente, 20/20).

### 🌐 Ejecución en Línea (DartPad)
* **Entorno Web Oficial:** [https://dartpad.dev/](https://dartpad.dev/)
* **Script Unificado Listo para Ejecutar:** [`lab_02/solucion_dartpad.dart`](lab_02/solucion_dartpad.dart)
  * Para probar en línea, simplemente copia el contenido de `lab_02/solucion_dartpad.dart`, pégalo en [DartPad](https://dartpad.dev/) y presiona **Run**.

### 🧩 Estructura de la Práctica 02
Cada ejercicio cuenta con su implementación modular y casos de prueba detallados:

1. **Ejercicio 1: List (Sección 3.3) — Merge Two Sorted Lists**
   * **Archivo:** [`lab_02/ejercicio1_list.dart`](lab_02/ejercicio1_list.dart)
   * **Descripción:** Fusión ordenada de dos listas enlazadas en una sola lista enlazada en tiempo $O(n + m)$ y espacio $O(1)$ usando punteros con `ListNode` y una solución alternativa funcional con `List<int>`.
   * **Ejecutar individualmente:**
     ```bash
     dart run lab_02/ejercicio1_list.dart
     ```

2. **Ejercicio 2: Map (Sección 4.5) — Intersección con Multiplicidad**
   * **Archivo:** [`lab_02/ejercicio2_map.dart`](lab_02/ejercicio2_map.dart)
   * **Descripción:** Intersección de dos arreglos considerando multiplicidad mediante tabla de frecuencias con `Map<int, int>` usando `update()` con `ifAbsent`.
   * **Ejecutar individualmente:**
     ```bash
     dart run lab_02/ejercicio2_map.dart
     ```

3. **Ejercicio 3: Set (Sección 5.3) — Asignación de Frutas en Cestas**
   * **Archivo:** [`lab_02/ejercicio3_set.dart`](lab_02/ejercicio3_set.dart)
   * **Descripción:** Asignación voraz de frutas en cestas disponibles de izquierda a derecha. Rastreabilidad de cestas ocupadas y cálculo de cestas libres con operaciones de conjuntos (`difference`, `contains`).
   * **Ejecutar individualmente:**
     ```bash
     dart run lab_02/ejercicio3_set.dart
     ```

4. **Solución Completa Unificada (DartPad):**
   * **Archivo:** [`lab_02/solucion_dartpad.dart`](lab_02/solucion_dartpad.dart)
   * **Ejecución local unificada:**
     ```bash
     dart run lab_02/solucion_dartpad.dart
     ```

### 🧪 Pruebas Unitarias (`lab_02_test.dart`)
Se incluye una suite completa de pruebas unitarias automatizadas con 11 casos de prueba cubriendo todos los ejemplos de la guía y casos de borde:

```bash
flutter test test/lab_02_test.dart
```

**Resultado de las pruebas:**
```text
00:00 +0: Práctica 02 - Pruebas Unitarias Ejercicio 1: Merge Two Sorted Lists (List) Ejemplo 1: [1,2,4] y [1,3,4] -> [1,1,2,3,4,4]
00:00 +1: Práctica 02 - Pruebas Unitarias Ejercicio 1: Merge Two Sorted Lists (List) Ejemplo 2: [] y [] -> []
00:00 +2: Práctica 02 - Pruebas Unitarias Ejercicio 1: Merge Two Sorted Lists (List) Ejemplo 3: [] y [0] -> [0]
00:00 +3: Práctica 02 - Pruebas Unitarias Ejercicio 1: Merge Two Sorted Lists (List) Solución nativa coincide con listas enlazadas
00:00 +4: Práctica 02 - Pruebas Unitarias Ejercicio 2: Intersection of Two Arrays II (Map) Ejemplo 1: [1,2,2,1] y [2,2] -> [2,2]
00:00 +5: Práctica 02 - Pruebas Unitarias Ejercicio 2: Intersection of Two Arrays II (Map) Ejemplo 2: [4,9,5] y [9,4,9,8,4] -> contiene 4 y 9
00:00 +6: Práctica 02 - Pruebas Unitarias Ejercicio 2: Intersection of Two Arrays II (Map) Sin intersección
00:00 +7: Práctica 02 - Pruebas Unitarias Ejercicio 3: Fruits into Baskets (Set) Ejemplo 1: frutas=[4,2,5], cestas=[3,5,4] -> 1
00:00 +8: Práctica 02 - Pruebas Unitarias Ejercicio 3: Fruits into Baskets (Set) Ejemplo 2: frutas=[3,6,1], cestas=[6,4,7] -> 0
00:00 +9: Práctica 02 - Pruebas Unitarias Ejercicio 3: Fruits into Baskets (Set) Todas las frutas superan capacidades -> n
00:00 +10: Práctica 02 - Pruebas Unitarias Ejercicio 3: Fruits into Baskets (Set) Caso idéntico: frutas=[5,5], cestas=[5,5] -> 0
00:00 +11: All tests passed!
```

### 📄 Informe Académico de Respaldo
* **Documento LaTeX:** [`docs/informe_practica02_dart.tex`](docs/informe_practica02_dart.tex)
  * Formato oficial con carátula institucional UNSAAC, análisis de complejidad, código fuente y alineación con la rúbrica oficial de 20 puntos.
* **Captura de Pantalla en DartPad:** [`docs/captura_dartpad_ejecucion.png`](docs/captura_dartpad_ejecucion.png)

---

## 📱 Práctica 01: Configuración de Flutter y Hola Mundo Móvil

Aplicación móvil base desarrollada con **Flutter** y **Dart**, estructurada bajo diseño reactivo con **Material Design 3** y probada en dispositivo físico Motorola Edge 60.

* **Código fuente:** [`lib/main.dart`](lib/main.dart)
* **Informe técnico:** [`docs/informe_hola_mundo_movil.tex`](docs/informe_hola_mundo_movil.tex)
* **Captura de ejecución móvil:** [`docs/captura_motorola_edge60.png`](docs/captura_motorola_edge60.png)
* **Prueba de widgets:** [`test/widget_test.dart`](test/widget_test.dart)

---

## 📁 Estructura del Directorio

```text
Desarrollo_SoftwareII/
├── docs/                                  # Informes formales en LaTeX y evidencias
│   ├── captura_dartpad_ejecucion.png     # Captura de pantalla de respaldo en DartPad
│   ├── captura_motorola_edge60.png       # Evidencia móvil de la Práctica 01
│   ├── informe_hola_mundo_movil.tex      # Informe LaTeX de la Práctica 01
│   ├── informe_practica02_dart.tex       # Informe LaTeX de la Práctica 02
│   └── unsaac.jpg                         # Logotipo institucional UNSAAC
├── lab_02/                                # Código fuente de la Práctica 02 (Dart)
│   ├── ejercicio1_list.dart              # Ejercicio propuesto 3.3 (List)
│   ├── ejercicio2_map.dart               # Ejercicio propuesto 4.5 (Map)
│   ├── ejercicio3_set.dart               # Ejercicio propuesto 5.3 (Set)
│   ├── guia02_dart.pdf                   # Guía oficial del laboratorio
│   └── solucion_dartpad.dart             # Solución completa para DartPad
├── lib/                                   # Código de la aplicación móvil (Práctica 01)
│   └── main.dart
├── test/                                  # Pruebas automatizadas
│   ├── lab_02_test.dart                  # Pruebas de los ejercicios de la Práctica 02
│   └── widget_test.dart                  # Pruebas de widgets de Flutter
├── android/, ios/, web/, windows/         # Plataformas compatibles Flutter
├── pubspec.yaml                           # Dependencias del proyecto
└── README.md                              # Documentación principal del repositorio
```
