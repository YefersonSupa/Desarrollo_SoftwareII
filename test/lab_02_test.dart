import 'package:flutter_test/flutter_test.dart';
import '../lab_02/ejercicio1_list.dart';
import '../lab_02/ejercicio2_map.dart';
import '../lab_02/ejercicio3_set.dart';

void main() {
  group('Práctica 02 - Pruebas Unitarias', () {
    group('Ejercicio 1: Merge Two Sorted Lists (List)', () {
      test('Ejemplo 1: [1,2,4] y [1,3,4] -> [1,1,2,3,4,4]', () {
        var n1 = listToLinkedList([1, 2, 4]);
        var n2 = listToLinkedList([1, 3, 4]);
        var res = mergeTwoLists(n1, n2);
        expect(linkedListToList(res), equals([1, 1, 2, 3, 4, 4]));
      });

      test('Ejemplo 2: [] y [] -> []', () {
        var res = mergeTwoLists(null, null);
        expect(linkedListToList(res), equals([]));
      });

      test('Ejemplo 3: [] y [0] -> [0]', () {
        var n2 = listToLinkedList([0]);
        var res = mergeTwoLists(null, n2);
        expect(linkedListToList(res), equals([0]));
      });

      test('Solución nativa coincide con listas enlazadas', () {
        expect(mergeNativeLists([1, 2, 4], [1, 3, 4]), equals([1, 1, 2, 3, 4, 4]));
        expect(mergeNativeLists([], [0]), equals([0]));
      });
    });

    group('Ejercicio 2: Intersection of Two Arrays II (Map)', () {
      test('Ejemplo 1: [1,2,2,1] y [2,2] -> [2,2]', () {
        var res = intersectWithMap([1, 2, 2, 1], [2, 2]);
        expect(res, equals([2, 2]));
      });

      test('Ejemplo 2: [4,9,5] y [9,4,9,8,4] -> contiene 4 y 9', () {
        var res = intersectWithMap([4, 9, 5], [9, 4, 9, 8, 4]);
        res.sort();
        expect(res, equals([4, 9]));
      });

      test('Sin intersección', () {
        var res = intersectWithMap([1, 3, 5], [2, 4, 6]);
        expect(res, isEmpty);
      });
    });

    group('Ejercicio 3: Fruits into Baskets (Set)', () {
      test('Ejemplo 1: frutas=[4,2,5], cestas=[3,5,4] -> 1', () {
        expect(numOfUnplacedFruits([4, 2, 5], [3, 5, 4]), equals(1));
      });

      test('Ejemplo 2: frutas=[3,6,1], cestas=[6,4,7] -> 0', () {
        expect(numOfUnplacedFruits([3, 6, 1], [6, 4, 7]), equals(0));
      });

      test('Todas las frutas superan capacidades -> n', () {
        expect(numOfUnplacedFruits([10, 20, 30], [2, 2, 2]), equals(3));
      });

      test('Caso idéntico: frutas=[5,5], cestas=[5,5] -> 0', () {
        expect(numOfUnplacedFruits([5, 5], [5, 5]), equals(0));
      });
    });
  });
}
