# Desarrollo de Aplicaciones Móviles (IF616AIN)

**Universidad Nacional de San Antonio Abad del Cusco (UNSAAC)**  
**Facultad de Ingeniería Eléctrica, Electrónica, Informática y Mecánica**  
**Escuela Profesional de Ingeniería Informática y de Sistemas**  

* **Asignatura:** Desarrollo de Aplicaciones Móviles (IF616AIN)
* **Semestre:** 2026-1
* **Docente:** Ing. CCACYAHUILLCA-BEJAR-HANS HARLEY
* **Estudiante:** SUPA CUSIPAUCAR, Yeferson (Código: 220553)

---

## 📱 Proyecto: Producto 1 - Hola Mundo Móvil

Aplicación móvil desarrollada con **Flutter** y **Dart**, estructurada bajo buenas prácticas de arquitectura y diseño reactivo con **Material Design 3**.

### 🛠️ Stack Tecnológico
* **Framework:** Flutter `3.47.4` (Canal Stable)
* **Lenguaje:** Dart `3.13.3`
* **Target Android:** Android SDK API 36 (Build-Tools 36.0.0)
* **JDK:** OpenJDK 17 (Eclipse Temurin)
* **Arquitectura:** Widgets reactivos (`StatelessWidget` y `StatefulWidget` con `setState`)

---

## 📂 Estructura del Repositorio

```text
├── android/          # Configuración y proyecto nativo de Android
├── docs/             # Informes académicos formales y documentación técnica (LaTeX/MD)
│   ├── informe_hola_mundo_movil.tex
│   └── informe_gestion_riesgos_cuscolimpio.tex
├── lib/
│   └── main.dart     # Código fuente principal de la aplicación móvil
├── test/
│   └── widget_test.dart # Pruebas automatizadas de interfaz y estado
└── pubspec.yaml      # Manifiesto de dependencias del proyecto
```

---

## 🚀 Instrucciones de Ejecución

### Prerrequisitos
Asegúrate de tener Flutter configurado (`flutter doctor`).

### Comandos de Ejecución
1. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

2. **Ejecutar pruebas automatizadas:**
   ```bash
   flutter test
   ```

3. **Ejecutar en tu dispositivo móvil (Android / Motorola Edge):**
   ```bash
   flutter run
   ```

4. **Ejecutar en el navegador web (Chrome):**
   ```bash
   flutter run -d chrome
   ```

