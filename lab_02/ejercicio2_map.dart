/// PRÁCTICA 02 - DESARROLLO DE SOFTWARE II (UNSAAC)
/// Ejercicio 4.5: Ejercicio propuesto con Map
/// Problema: Intersección de dos arreglos con multiplicidad (Intersection of Two Arrays II)
/// Autor: SUPA CUSIPAUCAR, Yeferson - 220553

/// Calcula la intersección de dos listas de enteros teniendo en cuenta la multiplicidad de cada elemento.
/// Emplea un Map<int, int> para almacenar la tabla de frecuencias del primer arreglo.
List<int> intersectWithMap(List<int> nums1, List<int> nums2) {
  // Mapa de frecuencias: clave = número, valor = cantidad de apariciones
  Map<int, int> frecuencia = {};

  // Construcción del mapa utilizando update con ifAbsent (mejores prácticas de Dart)
  for (int num in nums1) {
    frecuencia.update(num, (conteo) => conteo + 1, ifAbsent: () => 1);
  }

  List<int> resultado = [];

  // Búsqueda en el segundo arreglo y reducción controlada de frecuencias
  for (int num in nums2) {
    if (frecuencia.containsKey(num) && (frecuencia[num] ?? 0) > 0) {
      resultado.add(num);
      frecuencia[num] = frecuencia[num]! - 1;
    }
  }

  return resultado;
}

/// Función auxiliar para mostrar detalles pedagógicos del mapa de frecuencias
void imprimirAnalisisFrecuencias(List<int> nums) {
  Map<int, int> mapa = {};
  for (var n in nums) {
    mapa[n] = (mapa[n] ?? 0) + 1;
  }
  print('    Frecuencias registradas:');
  mapa.forEach((clave, valor) {
    print('      Elemento $clave -> $valor vez/veces');
  });
}

void main() {
  print('==================================================');
  print('EJERCICIO 2: INTERSECCIÓN DE DOS ARREGLOS (CON MAP)');
  print('==================================================\n');

  // Caso 1
  List<int> nums1_caso1 = [1, 2, 2, 1];
  List<int> nums2_caso1 = [2, 2];
  List<int> salida1 = intersectWithMap(nums1_caso1, nums2_caso1);
  print('Ejemplo 1:');
  print('  Entrada: nums1 = $nums1_caso1, nums2 = $nums2_caso1');
  imprimirAnalisisFrecuencias(nums1_caso1);
  print('  Salida: $salida1 (Esperado: [2, 2])\n');

  // Caso 2
  List<int> nums1_caso2 = [4, 9, 5];
  List<int> nums2_caso2 = [9, 4, 9, 8, 4];
  List<int> salida2 = intersectWithMap(nums1_caso2, nums2_caso2);
  print('Ejemplo 2:');
  print('  Entrada: nums1 = $nums1_caso2, nums2 = $nums2_caso2');
  imprimirAnalisisFrecuencias(nums1_caso2);
  print('  Salida: $salida2 (Esperado: [9, 4] o [4, 9])\n');

  // Caso 3 (Borde: sin intersección)
  List<int> nums1_caso3 = [1, 3, 5];
  List<int> nums2_caso3 = [2, 4, 6];
  List<int> salida3 = intersectWithMap(nums1_caso3, nums2_caso3);
  print('Ejemplo 3 (Sin coincidencias):');
  print('  Entrada: nums1 = $nums1_caso3, nums2 = $nums2_caso3');
  print('  Salida: $salida3 (Esperado: [])\n');
}
