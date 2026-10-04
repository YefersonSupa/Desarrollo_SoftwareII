/// PRÁCTICA 02 - DESARROLLO DE SOFTWARE II (UNSAAC)
/// Ejercicio 3.3: Ejercicio propuesto con List
/// Problema: Fusión de dos listas enlazadas ordenadas (Merge Two Sorted Lists)
/// Autor: SUPA CUSIPAUCAR, Yeferson - 220553

/// Definición de un nodo de lista enlazada simple
class ListNode {
  int val;
  ListNode? next;

  ListNode([this.val = 0, this.next]);

  @override
  String toString() {
    List<int> elements = [];
    ListNode? curr = this;
    while (curr != null) {
      elements.add(curr.val);
      curr = curr.next;
    }
    return elements.toString();
  }
}

/// Fusión de dos listas enlazadas ordenadas.
/// Retorna el nodo inicial de la lista enlazada resultante ordenada.
ListNode? mergeTwoLists(ListNode? list1, ListNode? list2) {
  // Nodo centinela (dummy node) para simplificar la inserción
  ListNode dummy = ListNode(-1);
  ListNode current = dummy;

  ListNode? p1 = list1;
  ListNode? p2 = list2;

  // Comparar nodo a nodo en orden no decreciente
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

  // Enlazar los elementos restantes de la lista que no haya terminado
  current.next = p1 ?? p2;

  return dummy.next;
}

/// Convierte una List<int> de Dart en una lista enlazada (ListNode?)
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

/// Convierte una lista enlazada (ListNode?) en una List<int> de Dart
List<int> linkedListToList(ListNode? head) {
  List<int> result = [];
  ListNode? current = head;
  while (current != null) {
    result.add(current.val);
    current = current.next;
  }
  return result;
}

/// Solución alternativa puramente nativa con List<int> (método funcional y dos punteros)
List<int> mergeNativeLists(List<int> lista1, List<int> lista2) {
  List<int> combinada = [...lista1, ...lista2];
  combinada.sort();
  return combinada;
}

void main() {
  print('==================================================');
  print('EJERCICIO 1: MERGE TWO SORTED LISTS (CON LIST)');
  print('==================================================\n');

  // Caso 1
  List<int> l1_caso1 = [1, 2, 4];
  List<int> l2_caso1 = [1, 3, 4];
  ListNode? nodo1 = listToLinkedList(l1_caso1);
  ListNode? nodo2 = listToLinkedList(l2_caso1);
  ListNode? fusion1 = mergeTwoLists(nodo1, nodo2);
  print('Ejemplo 1:');
  print('  Entrada: lista1 = $l1_caso1, lista2 = $l2_caso1');
  print('  Salida (ListNode): ${linkedListToList(fusion1)}');
  print('  Salida (Nativa List): ${mergeNativeLists(l1_caso1, l2_caso1)}\n');

  // Caso 2
  List<int> l1_caso2 = [];
  List<int> l2_caso2 = [];
  ListNode? fusion2 = mergeTwoLists(listToLinkedList(l1_caso2), listToLinkedList(l2_caso2));
  print('Ejemplo 2:');
  print('  Entrada: lista1 = $l1_caso2, lista2 = $l2_caso2');
  print('  Salida: ${linkedListToList(fusion2)}\n');

  // Caso 3
  List<int> l1_caso3 = [];
  List<int> l2_caso3 = [0];
  ListNode? fusion3 = mergeTwoLists(listToLinkedList(l1_caso3), listToLinkedList(l2_caso3));
  print('Ejemplo 3:');
  print('  Entrada: lista1 = $l1_caso3, lista2 = $l2_caso3');
  print('  Salida: ${linkedListToList(fusion3)}\n');
}
