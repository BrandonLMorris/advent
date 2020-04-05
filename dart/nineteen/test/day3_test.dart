import 'package:test/test.dart';
import 'package:advent/src/day3.dart';

void main() {
  test('simple test', () {
    expect(2 + 2, equals(4));
  });
  group('part one tests', () {
    test("Can parse a line", () {
      var res = parseLine('U3,R2,D1,L1');
      var expected = [
        Point(1, 0),
        Point(2, 0),
        Point(3, 0),
        Point(3, 1),
        Point(3, 2),
        Point(2, 2),
        Point(2, 1)
      ];
      expect(res.length, equals(expected.length));
      for (int i = 0; i < res.length; i++) {
        expect(res[i], equals(expected[i]));
      }
    });
    test("Can find collisions", () {
      var res =
          findCollisions(parseLine('U7,R6,D4,L4'), parseLine('R8,U5,L5,D3'));
      final expected = {Point(5, 6), Point(3, 3)};
      expect(res.length, equals(expected.length));
      for (var p in expected) {
        expect(res, contains(p));
      }
    });
    test("Works on sample inputs", () {
      expect(
          findClosestIntersection('U7,R6,D4,L4', 'R8,U5,L5,D3').manhattanDist,
          equals(6));
      expect(
          findClosestIntersection('R75,D30,R83,U83,L12,D49,R71,U7,L72',
                  'U62,R66,U55,R34,D71,R55,D58,R83')
              .manhattanDist,
          equals(159));
      expect(
          findClosestIntersection('R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51',
                  'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7')
              .manhattanDist,
          equals(135));
    });
  });
  group('part two tests', () {
    test("Part 2 sample input", () {
      expect(fewestCombinedSteps('R8,U5,L5,D3', 'U7,R6,D4,L4'), equals(30));
      expect(
          fewestCombinedSteps('R75,D30,R83,U83,L12,D49,R71,U7,L72',
              'U62,R66,U55,R34,D71,R55,D58,R83'),
          equals(610));
    });
  });
}
