import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class SemanticsScreen extends StatefulWidget {
  final bool showSemanticsDebugger;
  final ValueChanged<bool> onToggleSemanticsDebugger;

  const SemanticsScreen({
    super.key,
    required this.showSemanticsDebugger,
    required this.onToggleSemanticsDebugger,
  });

  @override
  State<SemanticsScreen> createState() => _SemanticsScreenState();
}

class _SemanticsScreenState extends State<SemanticsScreen> {
  bool _rememberPassword = false;
  int _cartCount = 0;
  bool _isLoading = false;

  void _addToCart() {
    setState(() {
      _cartCount++;
    });
    // Anuncio dinámico para lectores de pantalla
    SemanticsService.announce(
      'Reporte urbano añadido a la bandeja. Total en cola: $_cartCount',
      TextDirection.ltr,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reporte añadido. Total: $_cartCount (Anunciado a TalkBack/VoiceOver)'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleAsyncOperation() {
    setState(() => _isLoading = true);
    SemanticsService.announce('Sincronizando reportes con la base de datos municipal...', TextDirection.ltr);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
        SemanticsService.announce('Sincronización completada exitosamente.', TextDirection.ltr);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('4. Semántica & Lectores de Pantalla'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Barra de SemanticsDebugger
              Card(
                color: theme.colorScheme.primaryContainer,
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Superposición SemanticsDebugger',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Visualiza en pantalla el árbol de accesibilidad tal como lo interpreta TalkBack/VoiceOver.',
                              style: TextStyle(fontSize: 12, color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8)),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: widget.showSemanticsDebugger,
                        onChanged: widget.onToggleSemanticsDebugger,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Panel 1: Semantics en Widgets sin Texto
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
                          Icon(Icons.record_voice_over_rounded, color: theme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Semantics en Widgets Sin Texto',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Los widgets gráficos sin texto visible necesitan etiqueta y pista (label y hint) para TalkBack/VoiceOver.',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 14),
                      Center(
                        child: Semantics(
                          label: 'Foto de perfil del estudiante Yeferson Supa',
                          hint: 'Doble toque para cambiar la fotografía de perfil',
                          button: true,
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Acción: Cambiar foto de perfil')),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 44,
                                  backgroundColor: theme.colorScheme.primary,
                                  child: const Text('YS', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.edit, size: 16, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Panel 2: ExcludeSemantics para Decoración
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
                          const Icon(Icons.star_half_rounded, color: Colors.amber),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'ExcludeSemantics (Iconos Decorativos)',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Los iconos meramente ornamentales se excluyen del árbol semántico para no sobrecargar de lectura innecesaria al usuario.',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            // Excluido de lectura
                            const ExcludeSemantics(
                              child: Icon(Icons.auto_awesome, color: Colors.amber, size: 28),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Aviso destacado: El icono de destello a la izquierda está envuelto en ExcludeSemantics(). El lector solo verbaliza este texto útil.',
                                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Panel 3: MergeSemantics (Agrupación de controles)
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
                          const Icon(Icons.merge_type_rounded, color: Colors.indigo),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'MergeSemantics (Agrupación Coherente)',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Agrupa varios widgets en un único nodo semántico para que el lector lea "Recordar contraseña, casilla de verificación" en una sola frase.',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 12),
                      MergeSemantics(
                        child: InkWell(
                          onTap: () => setState(() => _rememberPassword = !_rememberPassword),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _rememberPassword,
                                  onChanged: (val) => setState(() => _rememberPassword = val ?? false),
                                ),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                    'Recordar credenciales institucionales en este dispositivo',
                                    style: TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Panel 4: Anuncios Dinámicos y LiveRegion
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
                          const Icon(Icons.campaign_outlined, color: Colors.deepPurple),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Anuncios Dinámicos (SemanticsService)',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Notifica cambios de estado en vivo sin requerir navegación mediante SemanticsService.announce() y Semantics(liveRegion: true).',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _addToCart,
                              icon: const Icon(Icons.add_shopping_cart),
                              label: const Text('Añadir Reporte a Cola'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _isLoading ? null : _toggleAsyncOperation,
                              icon: _isLoading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.sync),
                              label: Text(_isLoading ? 'Sincronizando...' : 'Sincronizar'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      // liveRegion para cambios de texto
                      Semantics(
                        liveRegion: true,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.purple.shade200),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.notifications_active, color: Colors.purple, size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Estado actual en vivo: $_cartCount reportes pendientes de envío municipal.',
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
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
            ],
          ),
        ),
      ),
    );
  }
}
