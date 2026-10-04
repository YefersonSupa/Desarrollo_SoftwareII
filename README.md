# Desarrollo de Software II - Práctica 02: Tipos de Datos en Dart

**Universidad Nacional de San Antonio Abad del Cusco (UNSAAC)**  
**Facultad de Ingeniería Eléctrica, Electrónica, Informática y Mecánica**  
**Escuela Profesional de Ingeniería Informática y de Sistemas**  

* **Asignatura:** Desarrollo de Software II
* **Semestre Académico:** 2026-I
* **Docente Responsable:** Ing. CCACYAHUILLCA-BEJAR-HANS HARLEY
* **Estudiante:** SUPA CUSIPAUCAR, Yeferson (Código: 220553)
* **Repositorio Oficial:** [https://github.com/YefersonSupa/Desarrollo_SoftwareII](https://github.com/YefersonSupa/Desarrollo_SoftwareII)
* **Entorno en Línea DartPad:** [https://dartpad.dev/](https://dartpad.dev/)

---

## 📌 Descripción de la Práctica 02

Resolución completa de los 3 problemas propuestos en la guía oficial de laboratorio ([`lab_02/guia02_dart.pdf`](lab_02/guia02_dart.pdf)), aplicando estructuras de datos nativas de Dart (`List`, `Map`, `Set`), *Null Safety* estricto y análisis de complejidad temporal y espacial (Rúbrica: 20/20).

---

## 🚀 1. Ejecución en Línea (DartPad)

Para ejecutar la solución completa en el navegador sin instalar nada:
1. Ingresa a **[https://dartpad.dev/](https://dartpad.dev/)**.
2. Copia el código fuente completo del archivo unificado: [`lab_02/solucion_dartpad.dart`](lab_02/solucion_dartpad.dart).
3. Pégalo en el editor de DartPad y pulsa el botón **Run** (o presiona `Ctrl + Enter`).
4. Los resultados de los 3 ejercicios se visualizarán ordenadamente en la consola interactiva.

---

## 🧩 2. Ejercicios Desarrollados (`lab_02/`)

### Ejercicio 1: Fusión de Listas Ordenadas (`List` y `ListNode`)
* **Archivo:** [`lab_02/ejercicio1_list.dart`](lab_02/ejercicio1_list.dart)
* **Sección Guía:** 3.3 (Merge Two Sorted Lists)
* **Complejidad:** Tiempo $O(n + m)$ | Espacio $O(1)$
* **Ejecución local:**
  ```bash
  dart run lab_02/ejercicio1_list.dart
  ```

### Ejercicio 2: Intersección con Multiplicidad (`Map<int, int>`)
* **Archivo:** [`lab_02/ejercicio2_map.dart`](lab_02/ejercicio2_map.dart)
* **Sección Guía:** 4.5 (Intersection of Two Arrays II)
* **Complejidad:** Tiempo $O(n + m)$ | Espacio $O(\min(n, m))$
* **Ejecución local:**
  ```bash
  dart run lab_02/ejercicio2_map.dart
  ```

### Ejercicio 3: Asignación de Frutas en Cestas (`Set<int>`)
* **Archivo:** [`lab_02/ejercicio3_set.dart`](lab_02/ejercicio3_set.dart)
* **Sección Guía:** 5.3 (Fruits into Baskets)
* **Complejidad:** Tiempo $O(n^2)$ | Espacio $O(n)$
* **Ejecución local:**
  ```bash
  dart run lab_02/ejercicio3_set.dart
  ```

### Solución Unificada
* **Archivo:** [`lab_02/solucion_dartpad.dart`](lab_02/solucion_dartpad.dart)
* **Ejecución local:**
  ```bash
  dart run lab_02/solucion_dartpad.dart
  ```

---

## 🧪 3. Pruebas Unitarias Automatizadas (`test/`)

Se implementó una suite completa de pruebas unitarias que valida todos los casos de prueba de la guía y casos de borde:

```bash
flutter test test/lab_02_test.dart
```

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

---

## 📄 4. Informe Académico y Evidencias (`docs/`)

* **Informe en LaTeX:** [`docs/informe_practica02_dart.tex`](docs/informe_practica02_dart.tex) (con carátula oficial institucional de la UNSAAC y rúbrica detallada).
* **Captura de pantalla de respaldo:** [`docs/captura_dartpad_ejecucion.png`](docs/captura_dartpad_ejecucion.png) (evidencia visual de ejecución en DartPad).
* **Logotipo institucional:** [`docs/unsaac.jpg`](docs/unsaac.jpg).

---

## 📂 5. Estructura Limpia del Repositorio

```text
Desarrollo_SoftwareII/
├── docs/                                  # Informe formal y capturas de respaldo
│   ├── captura_dartpad_ejecucion.png     # Captura de pantalla de la ejecución en DartPad
│   ├── informe_practica02_dart.tex       # Documento formal en LaTeX (UNSAAC)
│   └── unsaac.jpg                         # Logotipo oficial de la UNSAAC
├── lab_02/                                # Código fuente de la Práctica 02
│   ├── ejercicio1_list.dart              # Ejercicio 3.3 con List
│   ├── ejercicio2_map.dart               # Ejercicio 4.5 con Map
│   ├── ejercicio3_set.dart               # Ejercicio 5.3 con Set
│   ├── guia02_dart.pdf                   # Guía oficial del laboratorio
│   └── solucion_dartpad.dart             # Solución completa para DartPad
├── test/                                  # Pruebas automatizadas
│   └── lab_02_test.dart                  # Suite de pruebas unitarias (11 tests aprobados)
├── analysis_options.yaml                  # Reglas de análisis estático de Dart
├── pubspec.yaml                           # Dependencias para pruebas y SDK
├── pubspec.lock                           # Lockfile de dependencias
├── .gitignore                             # Filtro de archivos no requeridos
└── README.md                              # Documentación principal del repositorio
```
