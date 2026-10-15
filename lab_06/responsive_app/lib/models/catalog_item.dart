import 'package:flutter/material.dart';

class CatalogItem {
  final int id;
  final String title;
  final String category;
  final String description;
  final IconData icon;
  final Color accentColor;
  final double rating;
  final String semanticDescription;

  const CatalogItem({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.rating,
    required this.semanticDescription,
  });

  static List<CatalogItem> sampleItems() => const [
        CatalogItem(
          id: 1,
          title: 'Reporte de Alumbrado Público',
          category: 'Servicios Básicos',
          description: 'Averías en luminarias de avenidas del distrito de Santiago y Cusco.',
          icon: Icons.lightbulb_outline_rounded,
          accentColor: Color(0xFFD97706),
          rating: 4.8,
          semanticDescription: 'Elemento de catálogo 1: Reporte de Alumbrado Público, categoría Servicios Básicos, calificación 4.8 de 5.',
        ),
        CatalogItem(
          id: 2,
          title: 'Mantenimiento de Vías y Pistas',
          category: 'Infraestructura',
          description: 'Detección de baches y reparación de carpetas asfálticas urbanas.',
          icon: Icons.alt_route_rounded,
          accentColor: Color(0xFF2563EB),
          rating: 4.5,
          semanticDescription: 'Elemento de catálogo 2: Mantenimiento de Vías, categoría Infraestructura, calificación 4.5 de 5.',
        ),
        CatalogItem(
          id: 3,
          title: 'Puntos Verdes y Reciclaje',
          category: 'Medio Ambiente',
          description: 'Ubicación de contenedores diferenciados y recojo de residuos sólidos.',
          icon: Icons.recycling_rounded,
          accentColor: Color(0xFF16A34A),
          rating: 4.9,
          semanticDescription: 'Elemento de catálogo 3: Puntos Verdes, categoría Medio Ambiente, calificación 4.9 de 5.',
        ),
        CatalogItem(
          id: 4,
          title: 'Seguridad Ciudadana y Serenazgo',
          category: 'Seguridad',
          description: 'Alertas tempranas de auxilio y patrullaje preventivo barrial.',
          icon: Icons.shield_outlined,
          accentColor: Color(0xFFDC2626),
          rating: 4.7,
          semanticDescription: 'Elemento de catálogo 4: Seguridad Ciudadana, categoría Seguridad, calificación 4.7 de 5.',
        ),
        CatalogItem(
          id: 5,
          title: 'Parques y Jardines Urbanos',
          category: 'Espacio Público',
          description: 'Riego, poda y preservación de flora nativa en plazas cusqueñas.',
          icon: Icons.park_outlined,
          accentColor: Color(0xFF0D9488),
          rating: 4.6,
          semanticDescription: 'Elemento de catálogo 5: Parques y Jardines, categoría Espacio Público, calificación 4.6 de 5.',
        ),
        CatalogItem(
          id: 6,
          title: 'Mascotas y Zoonosis',
          category: 'Salud Pública',
          description: 'Campañas de vacunación, desparasitación y esterilización gratuita.',
          icon: Icons.pets_outlined,
          accentColor: Color(0xFF9333EA),
          rating: 4.9,
          semanticDescription: 'Elemento de catálogo 6: Mascotas y Zoonosis, categoría Salud Pública, calificación 4.9 de 5.',
        ),
        CatalogItem(
          id: 7,
          title: 'Defensa Civil y Emergencias',
          category: 'Prevención',
          description: 'Monitoreo de cauces, quebradas e inspecciones técnicas estructurales.',
          icon: Icons.warning_amber_rounded,
          accentColor: Color(0xFFEA580C),
          rating: 4.4,
          semanticDescription: 'Elemento de catálogo 7: Defensa Civil, categoría Prevención, calificación 4.4 de 5.',
        ),
        CatalogItem(
          id: 8,
          title: 'Tránsito y Transporte Público',
          category: 'Movilidad',
          description: 'Supervisión de rutas urbanas, semaforización y ciclovías seguras.',
          icon: Icons.directions_bus_filled_outlined,
          accentColor: Color(0xFF0284C7),
          rating: 4.3,
          semanticDescription: 'Elemento de catálogo 8: Tránsito y Transporte, categoría Movilidad, calificación 4.3 de 5.',
        ),
      ];
}
