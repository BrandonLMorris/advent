import 'package:test/test.dart';
import 'advent_day.dart';

class DayThree implements AdventDay {
  int dayNum = 3;
  void partOne(List<String> lines) => _partOne(lines);
  void partTwo(List<String> lines) => _partTwo(lines);
  void runAllTests() => _runAllTests();
}

void _partOne(var lines) {
  Point closest = findClosestIntersection(lines[0], lines[1]);
  print('Part 1: ${closest.manhattanDist}');
}

void _partTwo(var lines) {
  var res = fewestCombinedSteps(lines[0], lines[1]);
  print('Part 2: ${res}');
}

class Point {
  final int first;
  final int second;
  Point(this.first, this.second);

  @override
  bool operator ==(o) => o is Point && o.first == first && o.second == second;

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

Point findClosestIntersection(String line1, String line2) {
  Set<Point> collisions = findCollisions(parseLine(line1), parseLine(line2));
  assert(collisions.length > 0);
  Point closest = null;
  for (var collision in collisions) {
    if (closest == null || closest.manhattanDist > collision.manhattanDist) {
      closest = collision;
    }
  }
  return closest;
}

Set<Point> findCollisions(List<Point> path1, List<Point> path2) {
  return path1.toSet().intersection(path2.toSet());
}

// Take in a line of input and return a list of coordinates that the wire
// traverses
List<Point> parseLine(String line) {
  int row = 0;
  int col = 0;
  List<Point> locations = [];
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
      locations.add(Point(row, col));
    }
  }
  return locations;
}

// Returns the smallest sum of steps along two paths to a collision
int fewestCombinedSteps(String line1, String line2) {
  var path1 = parseLine(line1);
  var path2 = parseLine(line2);
  var collisions = findCollisions(path1, path2);
  int res = null;
  for (Point collision in collisions) {
    var sum = stepsToPoint(path1, collision) + stepsToPoint(path2, collision);
    if (res == null || sum < res) {
      res = sum;
    }
  }
  return res;
}

int stepsToPoint(List<Point> path, Point point) {
  int steps = path.indexOf(point);
  if (steps == -1) {
    throw ArgumentError('Point not found in the path');
  }
  // Offset by one to account for not including the origin in the path
  return steps + 1;
}

// Tests ---------------------------------------------------------------------

void _runAllTests() {
  partOneTests();
  partTwoTests();
}

void partOneTests() {
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

void partTwoTests() {
  test("Part 2 sample input", () {
    expect(fewestCombinedSteps('R8,U5,L5,D3', 'U7,R6,D4,L4'), equals(30));
    expect(
        fewestCombinedSteps('R75,D30,R83,U83,L12,D49,R71,U7,L72',
            'U62,R66,U55,R34,D71,R55,D58,R83'),
        equals(610));
  });
}
