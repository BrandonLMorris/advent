import 'dart:io';
import 'package:test/test.dart';

const inputFile = "input/day3.txt";
final file = File(inputFile);
final lines = file.readAsLinesSync();

int main() {
  runAllTests();
  partOneMain();
  partTwoMain();
}

void partOneMain() {
  Pair closest = findClosestIntersection(lines[0], lines[1]);
  print('Part 1: ${closest.manhattanDist}');
}

void partTwoMain() {}

class Pair {
  int first;
  int second;
  Pair(this.first, this.second);

  @override
  bool operator ==(o) => o is Pair && o.first == first && o.second == second;

  @override
  String toString() => "($first, $second)";

  @override
  int get hashCode {
    int res = 17;
    res = 31 * res + first;
    res = 31 * res + second;
    return res;
  }

  int get manhattanDist => first.abs() + second.abs();
}

Pair findClosestIntersection(String firstLine, String secondLine) {
  Set<Pair> collisions = findCollisions(firstLine, secondLine);
  assert(collisions.length > 0);
  Pair closest = null;
  for (var collision in collisions) {
    if (closest == null || closest.manhattanDist > collision.manhattanDist) {
      closest = collision;
    }
  }
  return closest;
}

Set<Pair> findCollisions(String firstLine, String secondLine) {
  return parseLine(firstLine).intersection(parseLine(secondLine));
}

// Take in a line of input and return a set of coordinates that the wire
// traverses
Set<Pair> parseLine(String line) {
  int row = 0;
  int col = 0;
  Set<Pair> locations = {};
  List<String> directions = line.split(',');
  for (var direction in directions) {
    var heading = direction[0];
    var dist = int.parse(direction.substring(1));
    for (int i = 0; i < dist; i++) {
      switch (heading) {
        case 'U':
          row += 1;
          break;
        case 'R':
          col += 1;
          break;
        case 'D':
          row -= 1;
          break;
        case 'L':
          col -= 1;
          break;
        default:
          print('ERROR! Bad direction $direction');
          break;
      }
      locations.add(Pair(row, col));
    }
  }
  return locations;
}

void runAllTests() {
  partOneTests();
  partTwoTests();
}

void partOneTests() {
  test("Test test, 1 2 3", () => expect(2 + 2, equals(4)));
  test("Can parse a line", () {
    var res = parseLine('U3,R2,D1,L1');
    var expected = {
      Pair(1, 0),
      Pair(2, 0),
      Pair(3, 0),
      Pair(3, 1),
      Pair(3, 2),
      Pair(2, 2),
      Pair(2, 1)
    };
    expect(res.length, equals(expected.length));
    for (var p in expected) {
      expect(res, contains(p));
    }
  });
  test("Can find collisions", () {
    var res = findCollisions('U7,R6,D4,L4', 'R8,U5,L5,D3');
    final expected = {Pair(5, 6), Pair(3, 3)};
    expect(res.length, equals(expected.length));
    for (var p in expected) {
      expect(res, contains(p));
    }
  });
  test("Works on sample inputs", () {
    expect(findClosestIntersection('U7,R6,D4,L4', 'R8,U5,L5,D3').manhattanDist,
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
}

void partTwoTests() {}
