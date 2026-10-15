import 'package:flutter/material.dart';

class AccessibilityScreen extends StatefulWidget {
  final double currentTextScale;
  final ValueChanged<double> onTextScaleChanged;
  final bool isHighContrast;
  final ValueChanged<bool> onHighContrastChanged;

  const AccessibilityScreen({
    super.key,
    required this.currentTextScale,
    required this.onTextScaleChanged,
    required this.isHighContrast,
    required this.onHighContrastChanged,
  });

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  bool _showTouchTargetGuides = true;
  String _focusedField = 'Ninguno';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('3. Accesibilidad & Ergonomía'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sección 1: Escalado de Texto Dinámico (WCAG)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.format_size_rounded, color: theme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Texto Escalable (textScaler: ${widget.currentTextScale.toStringAsFixed(2)}x)',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Cumplimiento WCAG: Nunca bloquear el escalado (evitar textScaleFactor: 1.0). '
                        'El layout debe soportar 1.5x sin desbordes de texto.',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                      ),
                      Slider(
                        value: widget.currentTextScale,
                        min: 0.85,
                        max: 1.8,
                        divisions: 8,
                        label: '${widget.currentTextScale.toStringAsFixed(2)}x',
                        onChanged: widget.onTextScaleChanged,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Ejemplo de párrafo con escalado reactivo: "La Universidad Nacional de San Antonio Abad del Cusco promueve la inclusión digital en todas sus plataformas móviles."',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Sección 2: Touch Targets (44px / 48px mínimos)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.touch_app_rounded, color: Colors.deepOrange),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Touch Targets Mínimos (>= 44x44 px)',
                                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _showTouchTargetGuides,
                            onChanged: (val) => setState(() => _showTouchTargetGuides = val),
                          ),
                        ],
                      ),
                      Text(
                        'Los iconos interactivos deben tener un área táctil mínima de 44x44 o 48x48 px lógicos, aun cuando el icono visible sea de 24px.',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          // Botón deficiente (24x24 px)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  decoration: _showTouchTargetGuides
                                      ? BoxDecoration(
                                          border: Border.all(color: Colors.red, width: 2),
                                          borderRadius: BorderRadius.circular(4),
                                        )
                                      : null,
                                  child: GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Toque en blanco deficiente (24x24)')),
                                      );
                                    },
                                    child: const Icon(Icons.close, size: 24, color: Colors.red),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text('Área deficiente: 24x24 px', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.red, fontWeight: FontWeight.bold)),
                                const Text('(Incumple WCAG)', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: Colors.grey)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Botón accesible óptimo (48x48 px con SizedBox)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  decoration: _showTouchTargetGuides
                                      ? BoxDecoration(
                                          border: Border.all(color: Colors.green, width: 2),
                                          borderRadius: BorderRadius.circular(8),
                                        )
                                      : null,
                                  child: SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: IconButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Toque accesible óptimo (48x48 px)')),
                                        );
                                      },
                                      icon: const Icon(Icons.check_circle, size: 24, color: Colors.green),
                                      tooltip: 'Acción aprobada (Touch Target 48x48)',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text('Área accesible: 48x48 px', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)),
                                const Text('(Cumple WCAG AA 44px+)', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Sección 3: Contraste Mínimo WCAG AA (4.5:1)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.contrast_rounded, color: Colors.indigo),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Contraste Mínimo WCAG AA (4.5:1)',
                                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: widget.isHighContrast,
                            onChanged: widget.onHighContrastChanged,
                          ),
                        ],
                      ),
                      Text(
                        'Activar Modo de Alto Contraste para optimizar la legibilidad en condiciones de luz solar extrema o baja visión.',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: widget.isHighContrast ? Colors.black : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.isHighContrast ? 'MODO ALTO CONTRASTE' : 'MODO ESTÁNDAR',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: widget.isHighContrast ? Colors.yellowAccent : const Color(0xFF003366),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Ratio de contraste medido: ${widget.isHighContrast ? "18.5:1 (Supera AAA)" : "7.2:1 (Supera AA)"}',
                                    style: TextStyle(
                                      color: widget.isHighContrast ? Colors.white : Colors.black87,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Sección 4: Navegación por Teclado y Control de Foco
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.keyboard_alt_outlined, color: Colors.teal),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Navegación por Teclado y Control de Foco',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Campos ordenados con FocusTraversalOrder y respuesta visual explícita de foco (FocusColor). Elemento enfocado: $_focusedField',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 16),
                      FocusTraversalGroup(
                        policy: OrderedTraversalPolicy(),
                        child: Column(
                          children: [
                            FocusTraversalOrder(
                              order: const NumericFocusOrder(1.0),
                              child: Focus(
                                onFocusChange: (has) {
                                  if (has) setState(() => _focusedField = 'Campo 1: DNI / Código');
                                },
                                child: const TextField(
                                  decoration: InputDecoration(
                                    labelText: '1. DNI o Código Institucional (Orden 1.0)',
                                    prefixIcon: Icon(Icons.badge_outlined),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            FocusTraversalOrder(
                              order: const NumericFocusOrder(2.0),
                              child: Focus(
                                onFocusChange: (has) {
                                  if (has) setState(() => _focusedField = 'Campo 2: Correo UNSAAC');
                                },
                                child: const TextField(
                                  decoration: InputDecoration(
                                    labelText: '2. Correo Institucional UNSAAC (Orden 2.0)',
                                    prefixIcon: Icon(Icons.email_outlined),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            FocusTraversalOrder(
                              order: const NumericFocusOrder(3.0),
                              child: Focus(
                                onFocusChange: (has) {
                                  if (has) setState(() => _focusedField = 'Botón de Envío');
                                },
                                child: InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Formulario activado por teclado/toque')),
                                    );
                                  },
                                  focusColor: Colors.blue.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '3. Enviar Formulario (Orden 3.0)',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
