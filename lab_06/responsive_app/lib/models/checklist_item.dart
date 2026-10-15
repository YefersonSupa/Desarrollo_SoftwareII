class ChecklistItem {
  final String id;
  final String category;
  final String title;
  final String description;
  bool isCompleted;

  ChecklistItem({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  static List<ChecklistItem> defaultList() => [
        // 1. Diseño Responsivo
        ChecklistItem(
          id: 'resp_1',
          category: 'Diseño Responsivo',
          title: 'Sin anchos fijos en contenedores principales',
          description: 'Uso de Expanded, Flexible, FractionallySizedBox o restricciones relativas en lugar de dimensiones en píxeles fijos.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'resp_2',
          category: 'Diseño Responsivo',
          title: 'Soporte horizontal y vertical (Portrait & Landscape)',
          description: 'La interfaz se reconfigura fluidamente al girar la pantalla sin provocar desbordes RenderFlex.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'resp_3',
          category: 'Diseño Responsivo',
          title: 'Escalabilidad usable de 320px a 1440px',
          description: 'Probada en pantallas ultra-pequeñas de teléfonos hasta monitores panorámicos de escritorio.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'resp_4',
          category: 'Diseño Responsivo',
          title: 'Imágenes sin distorsión ni desborde',
          description: 'Imágenes responsivas escaladas con BoxFit.contain/cover y límites de proporción adecuados.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'resp_5',
          category: 'Diseño Responsivo',
          title: 'Grids y listas con columnas dinámicas',
          description: 'AdaptiveGrid con SliverGridDelegateWithMaxCrossAxisExtent o cálculo dinámico con LayoutBuilder.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'resp_6',
          category: 'Diseño Responsivo',
          title: 'Navegación adaptativa por breakpoints',
          description: 'Cambio automático entre BottomNavigationBar (móvil) y NavigationRail (pantallas anchas/desktop).',
          isCompleted: true,
        ),

        // 2. Texto y Tipografía
        ChecklistItem(
          id: 'text_1',
          category: 'Texto y Tipografía',
          title: 'Legibilidad con textScaleFactor >= 1.5x',
          description: 'El texto se escala correctamente sin truncar palabras ni quebrar los contenedores.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'text_2',
          category: 'Texto y Tipografía',
          title: 'Sin bloqueo artificial del escalado de texto',
          description: 'No se fuerza textScaleFactor: 1.0; se respeta la configuración de accesibilidad del SO.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'text_3',
          category: 'Texto y Tipografía',
          title: 'Contraste mínimo WCAG AA (4.5:1)',
          description: 'Relación de contraste suficiente entre texto y fondo para asegurar legibilidad a usuarios con baja visión.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'text_4',
          category: 'Texto y Tipografía',
          title: 'Tamaño mínimo de fuente base >= 12px',
          description: 'Cuerpo de texto nunca inferior a 12px lógicos en su tamaño estándar sin zoom.',
          isCompleted: true,
        ),

        // 3. Accesibilidad
        ChecklistItem(
          id: 'acc_1',
          category: 'Accesibilidad',
          title: 'Navegación completa por teclado externo',
          description: 'Enfoque secuencial con Tab/Flechas y soporte de Focus, FocusTraversalOrder y foco visual.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'acc_2',
          category: 'Accesibilidad',
          title: 'Iconos interactivos con etiqueta semántica',
          description: 'Uso de Semantics(label: ..., hint: ...) o Tooltip para lectores de pantalla TalkBack y VoiceOver.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'acc_3',
          category: 'Accesibilidad',
          title: 'Áreas de toque mínimas de 44x44 px (Touch Targets)',
          description: 'Botones e iconos interactivos envueltos en áreas de al menos 44x44 o 48x48 píxeles lógicos.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'acc_4',
          category: 'Accesibilidad',
          title: 'Iconos e imágenes decorativas excluidos de semántica',
          description: 'Uso de ExcludeSemantics en elementos ornamentales para no saturar al lector de pantalla.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'acc_5',
          category: 'Accesibilidad',
          title: 'Anuncios dinámicos en cambios de estado',
          description: 'SemanticsService.announce y Semantics(liveRegion: true) para notificaciones en vivo.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'acc_6',
          category: 'Accesibilidad',
          title: 'Compatibilidad verificada con TalkBack / VoiceOver',
          description: 'Estructura validada a través de SemanticsDebugger y árbol semántico nativo.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'acc_7',
          category: 'Accesibilidad',
          title: 'Información no transmitida únicamente por color',
          description: 'Uso complementario de iconos, texto explícito y formas geométricas para daltonismo.',
          isCompleted: true,
        ),

        // 4. Pruebas
        ChecklistItem(
          id: 'test_1',
          category: 'Pruebas',
          title: 'Pruebas con flutter_test para semántica crítica',
          description: 'Validación automatizada en tests de etiquetas semánticas y tamaños de touch targets.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'test_2',
          category: 'Pruebas',
          title: 'Prueba en emulador o dispositivo móvil pequeño (5")',
          description: 'Verificación de pantalla compacta de 320-360px de ancho sin desbordes.',
          isCompleted: true,
        ),
        ChecklistItem(
          id: 'test_3',
          category: 'Pruebas',
          title: 'Prueba en tablet o modo escritorio extendido',
          description: 'Verificación de adaptación con NavigationRail y grillas multicolumna en resoluciones amplias.',
          isCompleted: true,
        ),
      ];
}
