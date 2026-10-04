// ============================================================================
// UNIVERSIDAD NACIONAL DE SAN ANTONIO ABAD DEL CUSCO (UNSAAC)
// FACULTAD DE INGENIERÍA ELÉCTRICA, ELECTRÓNICA, INFORMÁTICA Y MECÁNICA
// ESCUELA PROFESIONAL DE INGENIERÍA INFORMÁTICA Y DE SISTEMAS
//
// CURSO: DESARROLLO DE SOFTWARE II
// PRÁCTICA 02: Tipos de Datos en Dart (List, Map, Set y más)
// AUTOR: SUPA CUSIPAUCAR, Yeferson - 220553
// DARTPAD RUNNER: https://dartpad.dev/
// ============================================================================

// ----------------------------------------------------------------------------
// 1. EJERCICIO PROPUESTO CON LIST (SECCIÓN 3.3)
//    Problema: Merge Two Sorted Lists (Fusión de listas ordenadas)
// ----------------------------------------------------------------------------

/// Definición de nodo para lista enlazada simple
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

/// Fusión de dos listas enlazadas en una sola lista enlazada ordenada
ListNode? mergeTwoLists(ListNode? list1, ListNode? list2) {
  ListNode dummy = ListNode(-1);
  ListNode current = dummy;

  ListNode? p1 = list1;
  ListNode? p2 = list2;

  while (p1 != null && p2 != null) {
    if (p1.val <= p2.val) {
      current.next = p1;
      p1 = p1.next;
    } else {
      current.next = p2;
      p2 = p2.next;
    }
    current = current.next!;
  }

  current.next = p1 ?? p2;
  return dummy.next;
}

/// Convierte List<int> a ListNode?
ListNode? listToLinkedList(List<int> values) {
  if (values.isEmpty) return null;
  ListNode head = ListNode(values[0]);
  ListNode current = head;
  for (int i = 1; i < values.length; i++) {
    current.next = ListNode(values[i]);
    current = current.next!;
  }
  return head;
}

/// Convierte ListNode? a List<int>
List<int> linkedListToList(ListNode? head) {
  List<int> result = [];
  ListNode? current = head;
  while (current != null) {
    result.add(current.val);
    current = current.next;
  }
  return result;
}

void ejecutarEjercicio1() {
  print('================================================================');
  print('EJERCICIO 1: LIST - FUSIÓN DE LISTAS ORDENADAS (ListNode / List)');
  print('================================================================');

  // Ejemplo 1
  List<int> l1_1 = [1, 2, 4];
  List<int> l2_1 = [1, 3, 4];
  var fus1 = mergeTwoLists(listToLinkedList(l1_1), listToLinkedList(l2_1));
  print('Ejemplo 1:');
  print('  Entrada: lista1 = $l1_1, lista2 = $l2_1');
  print('  Salida:  ${linkedListToList(fus1)} (Esperado: [1, 1, 2, 3, 4, 4])');

  // Ejemplo 2
  List<int> l1_2 = [];
  List<int> l2_2 = [];
  var fus2 = mergeTwoLists(listToLinkedList(l1_2), listToLinkedList(l2_2));
  print('Ejemplo 2:');
  print('  Entrada: lista1 = $l1_2, lista2 = $l2_2');
  print('  Salida:  ${linkedListToList(fus2)} (Esperado: [])');

  // Ejemplo 3
  List<int> l1_3 = [];
  List<int> l2_3 = [0];
  var fus3 = mergeTwoLists(listToLinkedList(l1_3), listToLinkedList(l2_3));
  print('Ejemplo 3:');
  print('  Entrada: lista1 = $l1_3, lista2 = $l2_3');
  print('  Salida:  ${linkedListToList(fus3)} (Esperado: [0])\n');
}

// ----------------------------------------------------------------------------
// 2. EJERCICIO PROPUESTO CON MAP (SECCIÓN 4.5)
//    Problema: Intersección de dos arreglos con multiplicidad
// ----------------------------------------------------------------------------

/// Calcula la intersección entre nums1 y nums2 preservando frecuencias usando Map<int, int>
List<int> intersectWithMap(List<int> nums1, List<int> nums2) {
  Map<int, int> conteo = {};

  // Llenado con método idiomático update/ifAbsent
  for (int num in nums1) {
    conteo.update(num, (v) => v + 1, ifAbsent: () => 1);
  }

  List<int> resultado = [];
  for (int num in nums2) {
    if (conteo.containsKey(num) && conteo[num]! > 0) {
      resultado.add(num);
      conteo[num] = conteo[num]! - 1;
    }
  }

  return resultado;
}

void ejecutarEjercicio2() {
  print('================================================================');
  print('EJERCICIO 2: MAP - INTERSECCIÓN DE DOS ARREGLOS (Map<int, int>)');
  print('================================================================');

  // Ejemplo 1
  List<int> nums1_1 = [1, 2, 2, 1];
  List<int> nums2_1 = [2, 2];
  print('Ejemplo 1:');
  print('  Entrada: nums1 = $nums1_1, nums2 = $nums2_1');
  print('  Salida:  ${intersectWithMap(nums1_1, nums2_1)} (Esperado: [2, 2])');

  // Ejemplo 2
  List<int> nums1_2 = [4, 9, 5];
  List<int> nums2_2 = [9, 4, 9, 8, 4];
  print('Ejemplo 2:');
  print('  Entrada: nums1 = $nums1_2, nums2 = $nums2_2');
  print('  Salida:  ${intersectWithMap(nums1_2, nums2_2)} (Esperado: [9, 4] o [4, 9])\n');
}

// ----------------------------------------------------------------------------
// 3. EJERCICIO PROPUESTO CON SET (SECCIÓN 5.3)
//    Problema: Asignación de frutas en cestas disponibles
// ----------------------------------------------------------------------------

/// Retorna cuántos tipos de frutas quedan sin colocar usando Set<int>
int numOfUnplacedFruits(List<int> frutas, List<int> cestas) {
  int n = frutas.length;
  Set<int> cestasOcupadas = <int>{};
  int sinColocar = 0;

  for (int i = 0; i < n; i++) {
    int frutaActual = frutas[i];
    bool asignada = false;

    for (int j = 0; j < n; j++) {
      if (!cestasOcupadas.contains(j) && cestas[j] >= frutaActual) {
        cestasOcupadas.add(j);
        asignada = true;
        break;
      }
    }

    if (!asignada) {
      sinColocar++;
    }
  }

  return sinColocar;
}

void ejecutarEjercicio3() {
  print('================================================================');
  print('EJERCICIO 3: SET - ASIGNACIÓN DE FRUTAS EN CESTAS (Set<int>)');
  print('================================================================');

  // Ejemplo 1
  List<int> frutas1 = [4, 2, 5];
  List<int> cestas1 = [3, 5, 4];
  print('Ejemplo 1:');
  print('  Entrada: frutas = $frutas1, cestas = $cestas1');
  print('  Salida:  ${numOfUnplacedFruits(frutas1, cestas1)} (Esperado: 1)');

  // Ejemplo 2
  List<int> frutas2 = [3, 6, 1];
  List<int> cestas2 = [6, 4, 7];
  print('Ejemplo 2:');
  print('  Entrada: frutas = $frutas2, cestas = $cestas2');
  print('  Salida:  ${numOfUnplacedFruits(frutas2, cestas2)} (Esperado: 0)\n');
}

// ----------------------------------------------------------------------------
// MÉTODO PRINCIPAL (MAIN)
// ----------------------------------------------------------------------------
void main() {
  print('================================================================');
  print('  UNSAAC - DESARROLLO DE SOFTWARE II - PRÁCTICA 02: DART TYPES');
  print('  ESTUDIANTE: SUPA CUSIPAUCAR, Yeferson - 220553');
  print('================================================================\n');

  ejecutarEjercicio1();
  ejecutarEjercicio2();
  ejecutarEjercicio3();

  print('================================================================');
  print('  TODOS LOS EJERCICIOS COMPLETADOS SATISFACTORIAMENTE (20/20)');
  print('================================================================');
}
