# Desarrollo de Software II — UNSAAC

**Universidad Nacional de San Antonio Abad del Cusco (UNSAAC)**  
**Facultad de Ingeniería Eléctrica, Electrónica, Informática y Mecánica**  
**Escuela Profesional de Ingeniería Informática y de Sistemas**  

* **Asignatura:** Desarrollo de Software II (Código: IF616AIN)
* **Semestre Académico:** Décimo Semestre
* **Docente Responsable:** Ing. Hans Harley Ccacyahuillca Bejar
* **Estudiante:** SUPA CUSIPAUCAR, Yeferson — Código: 220553
* **Repositorio Oficial:** [GitHub - Desarrollo_SoftwareII](https://github.com/YefersonSupa/Desarrollo_SoftwareII)

---

## 📌 Descripción del Repositorio

Este repositorio contiene la totalidad de los entregables académicos, laboratorios prácticos, aplicaciones móviles desarrolladas en **Flutter & Dart**, suites de pruebas unitarias automatizadas y el proyecto semestral de ingeniería de software.

La arquitectura del repositorio sigue un enfoque **modular e independiente**, donde cada laboratorio constituye un paquete autónomo con su respectivo código fuente, pruebas unitarias verificadas, documentación técnica e informe formal en **LaTeX** con la carátula oficial institucional de la UNSAAC.

---

## 📂 Estructura General del Proyecto

```text
Desarrollo_SoftwareII/
├── lab_01/                              # Laboratorio 01: Entorno de Desarrollo y Hola Mundo
│   ├── hola_mundo/                      # App Flutter móvil y multiplataforma
│   ├── informe_laboratorio_01.tex       # Informe formal en LaTeX (UNSAAC)
│   ├── unsaac.jpg                       # Logo institucional para compilación
│   └── README.md                        # Documentación detallada del Laboratorio 01
│
├── lab_02/                              # Laboratorio 02: Tipos de Datos y Colecciones en Dart
│   ├── ejercicio1_list.dart             # Merge Two Sorted Lists (List y LinkedList)
│   ├── ejercicio2_map.dart              # Intersection of Two Arrays II (Map)
│   ├── ejercicio3_set.dart              # Fruits into Baskets (Set)
│   ├── solucion_dartpad.dart            # Solución unificada para ejecución en navegador
│   ├── guia02_dart.pdf                  # Guía de laboratorio oficial
│   ├── test/lab_02_test.dart            # 11 pruebas unitarias automatizadas
│   ├── informe_practica02_dart.tex      # Informe formal en LaTeX (UNSAAC)
│   └── README.md                        # Documentación detallada del Laboratorio 02
│
├── lab_03/                              # Laboratorio 03: Introducción a Flutter y Calculadora
│   ├── calculadora_app/                 # App Flutter (Ejercicios 1-3 y Calculadora Reactiva)
│   ├── capturas_*.png                   # Evidencias visuales de ejecución
│   ├── informe_laboratorio_03.tex       # Informe formal en LaTeX (UNSAAC)
│   ├── P_03_Flutter_AndroidStudio.pdf   # Guía de laboratorio oficial
│   └── README.md                        # Documentación detallada del Laboratorio 03
│
├── lab_04/                              # Laboratorio 04: Catálogo y Sandbox de 25 Widgets
│   ├── widgets_app/                     # App Flutter con catálogo interactivo y sandbox
│   ├── imagenes/                        # Capturas categorizadas (Layout, Display, Input, etc.)
│   ├── informe_laboratorio_04.tex       # Informe formal en LaTeX (UNSAAC)
│   └── README.md                        # Documentación detallada del Laboratorio 04
│
├── lab_05/                              # Laboratorio 05: Manejo de Eventos y Gestos en Flutter
│   ├── events_app/                      # App Flutter interactiva (Básicos, Intermedios, Avanzados)
│   ├── ej1.png ... ej9.png              # Capturas de ejecución en emulador
│   ├── informe_laboratorio_05.tex       # Informe formal en LaTeX (UNSAAC)
│   ├── PRÁCTICA 05_ eventos_flutter.pdf # Guía de laboratorio oficial
│   └── README.md                        # Documentación detallada del Laboratorio 05
│
├── lab_06/                              # Laboratorio 06: Diseño Responsivo y Accesible en Flutter
│   ├── responsive_app/                  # App Flutter (LayoutBuilder, Grilla adaptativa, WCAG AA, Semantics, Checklist)
│   ├── ej1.png ... ej5.png              # Evidencias visuales de los 5 módulos
│   ├── informe_laboratorio_06.tex       # Informe formal en LaTeX con carátula oficial UNSAAC
│   ├── unsaac.jpg                       # Logo institucional para compilación
│   ├── Guia06-flutter_*.pdf             # Guía oficial de cátedra
│   └── README.md                        # Documentación técnica completa y checklist de lanzamiento
│
├── cusco_reporta/                       # Proyecto Semestral: Plataforma de Reportes Urbanos
│   ├── frontend/                        # Cliente web interactivo (React + Vite)
│   ├── backend/                         # API RESTful (Node.js + Express)
│   ├── database/                        # Scripts SQL y esquemas relacionales
│   ├── PROTOTIPO.html                   # Mockup interactivo
│   └── README.md                        # Documentación de instalación y arquitectura
│
├── docs/                                # Documentación General y Respaldo Institucional
│   ├── propuesta_proyecto_cusco_reporta.tex # Propuesta formal del proyecto de software
│   ├── archivos_antiguos/               # Informes de respaldo de cursos previos
│   └── unsaac.jpg                       # Logo oficial institucional de alta resolución
│
├── analysis_options.yaml                # Reglas globales de análisis estático Dart/Flutter
└── .gitignore                           # Filtro de archivos no rastreados y temporales
```

---

## 📊 Matriz de Laboratorios y Proyectos

| Módulo | Descripción / Contenido | Tecnologías | Pruebas Automatizadas | Estado |
| :--- | :--- | :--- | :---: | :---: |
| **Lab 01** | Instalación del entorno, arquitectura de widgets y app "Hola Mundo Móvil" | Flutter, Dart | Widget Smoke Test (100% OK) | ✅ Concluido |
| **Lab 02** | Algoritmos y tipos de datos: `List`, `Map`, `Set`, análisis de complejidad | Dart, DartPad | 11 Tests Unitarios (100% OK) | ✅ Concluido |
| **Lab 03** | Layouts, StatefulWidget y Calculadora interactiva con color dinámico | Flutter, Dart | 12 Tests Unitarios (100% OK) | ✅ Concluido |
| **Lab 04** | Catálogo exhaustivo y sandbox en vivo de 25 widgets esenciales | Flutter, Dart | 6 Tests Automatizados (100% OK) | ✅ Concluido |
| **Lab 05** | Eventos táctiles, gestos (`GestureDetector`), controladores y animaciones | Flutter, Dart | 10 Tests Unitarios (100% OK) | ✅ Concluido |
| **Lab 06** | Diseño responsivo, breakpoints adaptativos, accesibilidad WCAG AA, semántica y checklist de 20 criterios | Flutter, Dart, Material 3 | 9 Tests Unitarios/Widgets (100% OK) | ✅ Concluido |
| **Proyecto**| "Cusco Reporta": Plataforma ciudadana para reporte y gestión de incidencias | React, Node.js, SQL | Verificación Funcional | 🚀 En Desarrollo |

---

## 🚀 Guía Rápida de Ejecución

### Ejecutar Pruebas Automatizadas por Laboratorio

Cada laboratorio dispone de su propio entorno de pruebas. Para ejecutarlas:

```bash
# Laboratorio 01 (Smoke Test)
cd lab_01/hola_mundo
flutter test

# Laboratorio 02 (Pruebas Unitarias de Algoritmos)
cd ../../lab_02
flutter test

# Laboratorio 03 (Pruebas de Lógica de Calculadora)
cd ../lab_03/calculadora_app
flutter test test/calculadora_test.dart

# Laboratorio 04 (Pruebas de Widgets y Navegación)
cd ../../lab_04/widgets_app
flutter test

# Laboratorio 05 (Pruebas de Eventos y Formularios)
cd ../../lab_05/events_app
flutter test

# Laboratorio 06 (Pruebas de Responsividad, Breakpoints y Accesibilidad)
cd ../../lab_06/responsive_app
flutter test
```

### Ejecutar Aplicaciones Flutter en Escritorio (Windows)

```bash
cd lab_06/responsive_app # o cualquier otra app
flutter run -d windows
```

### Compilar Informes en LaTeX

Todos los informes se encuentran en sus respectivas subcarpetas y pueden compilarse con cualquier distribución de LaTeX (`pdflatex` o `xelatex`):

```bash
cd lab_06
pdflatex informe_laboratorio_06.tex
```

