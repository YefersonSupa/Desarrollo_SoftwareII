/// PRÁCTICA 02 - DESARROLLO DE SOFTWARE II (UNSAAC)
/// Ejercicio 5.3: Ejercicio propuesto con Set (Conjuntos)
/// Problema: Asignación de tipos de frutas en cestas (Fruits into Baskets)
/// Autor: SUPA CUSIPAUCAR, Yeferson - 220553

/// Devuelve el número de tipos de fruta que quedan sin colocar.
/// Reglas:
/// 1. Cada tipo de fruta se coloca en la cesta disponible más a la izquierda con capacidad >= cantidad de esa fruta.
/// 2. Cada cesta solo puede contener un tipo de fruta.
/// 3. Se utiliza Set<int> para registrar y gestionar el conjunto de cestas ocupadas y disponibles.
int numOfUnplacedFruits(List<int> frutas, List<int> cestas, {bool verbose = false}) {
  int n = frutas.length;
  Set<int> cestasOcupadas = <int>{};
  int sinColocar = 0;

  for (int i = 0; i < n; i++) {
    int frutaActual = frutas[i];
    bool asignada = false;

    // Buscar de izquierda a derecha la primera cesta disponible
    for (int j = 0; j < n; j++) {
      // Verificación de pertenencia al conjunto: O(1) con Set
      if (!cestasOcupadas.contains(j) && cestas[j] >= frutaActual) {
        cestasOcupadas.add(j);
        asignada = true;
        if (verbose) {
          print('    -> Fruta tipo $i (cant: $frutaActual) asignada a Cesta $j (cap: ${cestas[j]})');
        }
        break;
      }
    }

    if (!asignada) {
      sinColocar++;
      if (verbose) {
        print('    -> Fruta tipo $i (cant: $frutaActual) NO encontró cesta disponible con suficiente capacidad');
      }
    }
  }

  if (verbose) {
    Set<int> universoCestas = Set<int>.from(List.generate(n, (i) => i));
    Set<int> cestasLibres = universoCestas.difference(cestasOcupadas);
    print('    Resumen de Conjuntos:');
    print('      Cestas ocupadas (Set): $cestasOcupadas');
    print('      Cestas libres (Diferencia Set): $cestasLibres');
  }

  return sinColocar;
}

void main() {
  print('==================================================');
  print('EJERCICIO 3: ASIGNACIÓN DE FRUTAS EN CESTAS (CON SET)');
  print('==================================================\n');

  // Ejemplo 1
  List<int> frutas1 = [4, 2, 5];
  List<int> cestas1 = [3, 5, 4];
  print('Ejemplo 1:');
  print('  Entrada: frutas = $frutas1, cestas = $cestas1');
  int res1 = numOfUnplacedFruits(frutas1, cestas1, verbose: true);
  print('  Salida: $res1 (Frutas sin colocar)\n');

  // Ejemplo 2
  List<int> frutas2 = [3, 6, 1];
  List<int> cestas2 = [6, 4, 7];
  print('Ejemplo 2:');
  print('  Entrada: frutas = $frutas2, cestas = $cestas2');
  int res2 = numOfUnplacedFruits(frutas2, cestas2, verbose: true);
  print('  Salida: $res2 (Frutas sin colocar)\n');

  // Ejemplo 3 (Borde: capacidades insuficientes para todas)
  List<int> frutas3 = [10, 20, 30];
  List<int> cestas3 = [5, 5, 5];
  print('Ejemplo 3 (Capacidad insuficiente):');
  print('  Entrada: frutas = $frutas3, cestas = $cestas3');
  int res3 = numOfUnplacedFruits(frutas3, cestas3, verbose: true);
  print('  Salida: $res3 (Frutas sin colocar)\n');
}
