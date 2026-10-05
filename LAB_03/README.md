# Laboratorio 03: Introducción a Flutter en Android Studio
## Asignatura: Desarrollo de Software II — UNSAAC

**Estudiante:** SUPA CUSIPAUCAR, Yeferson — Código: 220553  
**Docente Responsable:** Ing. Hans Harley Ccacyahuillca Bejar  
**Institución:** Universidad Nacional de San Antonio Abad del Cusco  
**Facultad:** Facultad de Ingeniería Eléctrica, Electrónica, Informática y Mecánica  
**Escuela Profesional:** Ingeniería Informática y de Sistemas  
**Semestre Académico:** 2026-II (Décimo Semestre)  
**Repositorio Oficial:** [GitHub - Desarrollo_SoftwareII](https://github.com/YefersonSupa/Desarrollo_SoftwareII)

---

## 1. Resumen de Contenidos Desarrollados

Este directorio contiene la resolución completa de la **Práctica N° 1 (Laboratorio 03)**:

1. **Ejercicio Guiado 1: Hola Mundo en Flutter**
   - Estructura base con `MaterialApp`, `Scaffold`, `AppBar`, `Center` y `Text`.
   - Archivo: `calculadora_app/lib/screens/ejercicio1_screen.dart` (y lanzador `ejercicio1_main.dart`).

2. **Ejercicio Guiado 2: Tarjeta de Perfil con Layout Widgets**
   - Composición de interfaz visual con `Card`, `CircleAvatar`, `Row`, `Column`, `Divider`, `_Estadistica` y `ElevatedButton.icon`.
   - Perfil de Ada Lovelace con estadísticas de proyectos, rating y años de experiencia.
   - Archivo: `calculadora_app/lib/screens/ejercicio2_screen.dart` (y lanzador `ejercicio2_main.dart`).

3. **Ejercicio Guiado 3: Contador Interactivo con StatefulWidget**
   - Gestión de estado mutable mediante `setState()`.
   - Botones para Decrementar (`-`), Reset (`↺`) e Incrementar (`+`).
   - Interpolación fluida de color con `AnimatedDefaultTextStyle`: Gris (0), Azul (< 5), Verde (>= 5).
   - Archivo: `calculadora_app/lib/screens/ejercicio3_screen.dart` (y lanzador `ejercicio3_main.dart`).

4. **Ejercicio Propuesto: Calculadora Básica con Display Reactivo**
   - Display con historial de operación y número actual con ajuste automático de escala (`FittedBox`).
   - Teclado matricial completo: dígitos `0-9`, punto decimal `.`, operaciones aritméticas `+`, `-`, `×`, `÷`, `C` (Clear), `=` (Calcular), `DEL` (Borrar dígito), `+/-` (Cambio de signo) y `%` (Porcentaje).
   - **Regla visual de color del display**:
     - **Azul:** Valor estrictamente positivo (`> 0`).
     - **Rojo:** Valor negativo (`< 0`) o condición de error.
     - **Gris:** Valor igual a cero (`= 0`) o estado inicial en reposo.
   - Arquitectura desacoplada: lógica pura en `CalculatorLogic` y UI en `CalculadoraScreen`.
   - Diseño responsivo mediante filas y columnas expandidas que previene cualquier desborde de píxeles (`RenderFlex overflow`).
   - Archivos:
     - `calculadora_app/lib/models/calculator_logic.dart`
     - `calculadora_app/lib/screens/calculadora_screen.dart`
     - `calculadora_app/lib/calculadora_main.dart`

5. **Aplicación Integrada con Navegación:**
   - `calculadora_app/lib/main.dart` integra los 4 ejercicios en una sola aplicación con barra de navegación (`NavigationBar`) interactiva, abriendo por defecto la **Calculadora**.

---

## 2. Estructura de Archivos del Laboratorio

```text
LAB_03/
├── P_03_Flutter_AndroidStudio.pdf       # Guía oficial del laboratorio proporcionada
├── unsaac.jpg                           # Logo oficial para el informe institucional
├── informe_laboratorio_03.tex           # Informe técnico oficial en LaTeX (Carátula UNSAAC e imágenes)
├── README.md                            # Guía y documentación general del laboratorio
├── captura_ejercicio1_holamundo.png     # Captura de pantalla del Ejercicio 1 (Hola Mundo)
├── captura_perfil_ada_lovelace.png      # Captura de pantalla del Ejercicio 2 (Tarjeta de Perfil)
├── captura_ejercicio3_contador.png      # Captura de pantalla del Ejercicio 3 (Contador Interactivo)
├── captura_calculadora_cero.png         # Captura de la Calculadora en reposo (Cero - Gris)
├── captura_calculadora_positivo.png     # Captura de la Calculadora con resultado positivo (Azul)
├── captura_calculadora_negativo.png     # Captura de la Calculadora con resultado negativo (Rojo)
└── calculadora_app/                     # Proyecto Flutter completo y configurable
    ├── pubspec.yaml                     # Manifiesto de dependencias y metadatos
    ├── analysis_options.yaml            # Reglas de linting de Dart
    ├── lib/
    │   ├── main.dart                    # Aplicación unificada con NavigationBar
    │   ├── calculadora_main.dart        # Lanzador directo de la Calculadora
    │   ├── ejercicio1_main.dart         # Lanzador directo del Ejercicio 1
    │   ├── ejercicio2_main.dart         # Lanzador directo del Ejercicio 2
    │   ├── ejercicio3_main.dart         # Lanzador directo del Ejercicio 3
    │   ├── models/
    │   │   └── calculator_logic.dart    # Lógica desacoplada de la calculadora
    │   └── screens/
    │       ├── calculadora_screen.dart  # Pantalla de la calculadora interactiva
    │       ├── ejercicio1_screen.dart   # Pantalla Ejercicio 1 (Hola Mundo)
    │       ├── ejercicio2_screen.dart   # Pantalla Ejercicio 2 (Tarjeta de Perfil)
    │       └── ejercicio3_screen.dart   # Pantalla Ejercicio 3 (Contador Interactivo)
    └── test/
        ├── calculadora_test.dart        # 12 pruebas unitarias para CalculatorLogic
        └── widget_test.dart             # 2 pruebas de widgets e interacción de UI
```

---

## 3. Cuestionario Resuelto (Sección 5 de la Guía)

### 1. ¿Cuál es la diferencia fundamental entre un StatelessWidget y un StatefulWidget? Proporcione un ejemplo de uso de cada uno.
- **StatelessWidget:** Es inmutable. Su apariencia visual depende exclusivamente de los parámetros recibidos en su constructor. Su método `build()` solo se vuelve a ejecutar si el widget padre se reconstruye pasándole nuevos datos o si se actualiza un `InheritedWidget`. No tiene estado interno que persista entre reconstrucciones.  
  *Ejemplo:* Un texto estático (`Text('Ada Lovelace')`), un icono (`Icon(Icons.person)`), o una tarjeta de información fija (`Card`).
- **StatefulWidget:** Es dinámico. Se compone de dos clases: el widget inmutable y un objeto persistente `State<T>` que sobrevive en memoria. Permite mantener variables mutables que cambian en respuesta a acciones del usuario, respuestas de red o temporizadores. Cada vez que se llama a `setState()`, el framework marca el elemento como "sucio" (*dirty*) y reconstruye su subárbol.  
  *Ejemplo:* Un campo de texto (`TextField`), un checkbox, un contador con botones interactivos o la calculadora desarrollada en esta práctica.

### 2. ¿Por qué Flutter no usa componentes nativos del sistema operativo para renderizar su interfaz?
1. **Eliminación del puente de comunicación (*Bridge Bottleneck*):** En frameworks como React Native, los eventos e instrucciones visuales deben cruzar continuamente un puente de serialización JSON entre el runtime de JavaScript y los componentes nativos de Android (`android.widget.*`) o iOS (`UIView`), lo que provoca retrasos y caídas de fotogramas.
2. **Consistencia Píxel a Píxel (*Pixel-Perfect Consistency*):** Flutter dibuja directamente sobre un lienzo (*Canvas*) utilizando su propio motor de renderizado de bajo nivel en C++ (**Skia** o **Impeller**). Esto garantiza que la interfaz se vea exactamente igual en cualquier dispositivo, fabricante o versión de sistema operativo.
3. **Rendimiento predecible a 60 / 120 FPS:** Al controlar la canalización completa de renderizado (Animación -> Construcción -> Diseño -> Dibujo), Flutter optimiza las operaciones directamente sobre la GPU mediante Vulkan, Metal o DirectX.
4. **Composabilidad sin restricciones:** Cualquier widget puede transformarse, rotarse, escalarse, recortarse o combinarse libremente sin verse limitado por las restricciones de las vistas nativas del SO.

### 3. Explique qué hace el comando `flutter doctor` y para qué sirve cada sección de su resultado.
`flutter doctor` es la herramienta de diagnóstico del entorno de Flutter. Analiza el sistema local para verificar si se encuentran instaladas todas las dependencias y herramientas requeridas para compilar:
- **Flutter SDK / Channel:** Valida la versión del framework, canal de lanzamiento (stable/beta/master) y la versión de Dart incluida.
- **Android toolchain:** Verifica que el Android SDK, las herramientas de compilación (`platform-tools`, `build-tools`), el JDK de Java y las licencias de Android estén instaladas y aceptadas.
- **Chrome / Web:** Verifica la presencia del navegador Google Chrome para la ejecución y depuración web.
- **Visual Studio / Windows Desktop:** En Windows, certifica las herramientas de compilación en C++ necesarias para generar ejecutables de escritorio nativos.
- **Connected device:** Lista todos los dispositivos físicos conectados, emuladores disponibles y destinos de escritorio/navegador listos para ejecutar la aplicación.
- **Network resources:** Valida que exista conectividad hacia los servidores de descarga de paquetes de Google y `pub.dev`.

### 4. ¿Qué sucede internamente cuando se llama `setState()`? Describa el proceso de reconstrucción del widget tree.
1. **Ejecución del callback:** Se ejecuta el bloque de código síncrono pasado a `setState(() { ... })`, mutando las variables del objeto `State`.
2. **Marcado como *Dirty*:** El objeto `State` llama a `_element.markNeedsBuild()`. El `StatefulElement` correspondiente en el **Element Tree** se marca como sucio (*dirty*) y se añade a la lista de elementos por reconstruir del `BuildOwner`.
3. **Programación del frame:** El framework solicita al planificador un nuevo ciclo de sincronización vertical (VSYNC).
4. **Ejecución de `build()`:** Al llegar el frame, el framework ejecuta el método `build()` únicamente de los widgets marcados como sucios, generando un nuevo subárbol de widgets inmutables.
5. **Reconciliación (*Diffing*):** El `Element` compara el nuevo widget con el anterior evaluando `Widget.canUpdate()` (mismo `runtimeType` y misma `key`). Si coinciden, actualiza su referencia sin destruir el nodo en pantalla.
6. **Layout y Paint selectivos:** Si cambiaron propiedades de tamaño o posición, se llama a `layout()`; si solo cambió apariencia (como colores del display), únicamente se ejecuta `paint()` hacia la GPU.

### 5. ¿Cuál es la diferencia entre Hot Reload y Hot Restart en Flutter?
- **Hot Reload (`r`):** Inyecta el código modificado directamente en la máquina virtual de Dart (Dart VM) en ejecución. **Conserva el estado de la aplicación en memoria** (las variables de estado, formularios y números no se reinician) y solo reconstruye los widgets afectados. Es instantáneo (200 - 500 ms).
- **Hot Restart (`R`):** Reinicia por completo la máquina virtual de Dart. **Destruye y reinicia todo el estado en memoria** a sus valores por defecto y vuelve a ejecutar la función `main()` desde el inicio. Tarda entre 1 y 2 segundos. Es necesario cuando se modifica el ciclo de vida inicial (`initState()`), variables globales o dependencias del proyecto.

---

## 4. Guía de Ejecución y Pruebas

### Requisitos Previos
Tener Flutter SDK instalado y agregado al PATH. Puede verificarse ejecutando:
```bash
flutter doctor
```

### Ejecución de Pruebas Automatizadas
Para verificar el 100% de las 14 pruebas unitarias y de widgets:
```bash
cd LAB_03/calculadora_app
flutter test
```

### Análisis Estático de Código (0 errores / 0 advertencias)
```bash
cd LAB_03/calculadora_app
flutter analyze
```

### Ejecución en Diferentes Dispositivos

1. **En Windows Desktop (Recomendado por rapidez, sin necesidad de emulador):**
   ```bash
   cd LAB_03/calculadora_app
   flutter run -d windows
   ```

2. **En Google Chrome (Web):**
   ```bash
   cd LAB_03/calculadora_app
   flutter run -d chrome
   ```

3. **En Android Studio / Emulador Android:**
   - Abrir **Android Studio**.
   - Menú **File -> Open** y seleccionar la carpeta: `LAB_03/calculadora_app`.
   - Abrir **Device Manager** e iniciar su emulador (Pixel con Android 13/14).
   - Presionar el botón verde **Run** (`Shift + F10`) con `lib/main.dart` seleccionado.

---

## 5. Control de Versiones (Git)

Para confirmar y sincronizar los entregables en el repositorio oficial de GitHub:

```bash
cd c:\Users\yefer\Desktop\Decimo-Semestre\Desarrollo_SoftwareII
git status
git add LAB_03/ docs/
git commit -m "feat(lab03): desarrollo integral de practica 01 flutter, ejercicios 1-3, calculadora interactiva, pruebas y documentacion"
git push origin main
```
