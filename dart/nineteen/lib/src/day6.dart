import 'dart:math';
import 'advent_day.dart';
import 'package:test/test.dart';

class DaySix implements AdventDay {
  int dayNum = 6;

  void partOne(List<String> lines) => _partOne(lines);

  void partTwo(List<String> lines) => _partTwo(lines);

  void runAllTests() => _runAllTests();
}

void _partOne(List<String> lines) {
  var orbits = _processOrbits(lines);
  print('${_tallyAllOrbits(orbits)}');
}

void _partTwo(List<String> lines) {
  var orbits = _processOrbitsUndirected(lines);
  print('${_minimumTransfers(orbits)}');
}

Map<String, List<String>> _processOrbits(List<String> lines) {
  var orbits = Map<String, List<String>>();
  for (var line in lines) {
    // Orbits are always 3 characters, ')', three characters
    var first = line.substring(0, 3);
    var second = line.substring(4);
    if (!orbits.containsKey(first)) {
      orbits[first] = List<String>();
    }
    orbits[first].add(second);
  }
  return orbits;
}

// Starting with COM, do a DFS and add depth of each node
int _tallyAllOrbits(Map<String, List<String>> orbits) {
  List<int> depths = [0];
  List<String> toVisit = ['COM'];
  int count = 0;
  while (toVisit.length > 0) {
    var current = toVisit.removeLast();
    var depth = depths.removeLast();
    // visit this node
    count += depth;
    if (orbits[current] != null) {
      for (var neighbor in orbits[current]) {
        toVisit.add(neighbor);
        depths.add(depth + 1);
      }
    }
  }
  return count;
}

Map<String, Set<String>> _processOrbitsUndirected(List<String> lines) {
  var orbits = Map<String, Set<String>>();
  for (var line in lines) {
    var first = line.substring(0, 3), second = line.substring(4);
    for (var planet in [first, second]) {
      if (!orbits.containsKey(planet)) orbits[planet] = Set<String>();
    }
    orbits[first].add(second);
    orbits[second].add(first);
  }
  return orbits;
}

// Do a bfs from YOU to SAN to find the minimum number of transfers
int _minimumTransfers(Map<String, Set<String>> orbits) {
  var visited = {'YOU'};
  int transfers = 0;
  var neighbors = orbits['YOU'];
  while (!neighbors.contains('SAN')) {
    transfers += 1;
    // Add all the planets that can be reached at dist transfers
    var newNeighbors = Set<String>();
    for (var neighbor in neighbors) {
      if (visited.contains(neighbor)) continue;
      visited.add(neighbor);
      newNeighbors.addAll(orbits[neighbor]);
    }
    neighbors = newNeighbors;
  }
  return max(transfers - 1, 0);
}

void _runAllTests() {
  // com - ddd - aaa - bbb - ccc
  var simple = ['aaa)bbb', 'bbb)ccc', 'COM)ddd', 'ddd)aaa'];
  // com - aaa - bbb - ccc
  //          \ eee - fff
  var branched = ['COM)aaa', 'aaa)bbb', 'bbb)ccc', 'aaa)eee', 'eee)fff'];
  var sampleInput = [
    'COM)xxB',
    'xxB)xxC',
    'xxC)xxD',
    'xxD)xxE',
    'xxE)xxF',
    'xxB)xxG',
    'xxG)xxH',
    'xxD)xxI',
    'xxE)xxJ',
    'xxJ)xxK',
    'xxK)xxL',
  ];
  group('part one', () {
    test("processes orbits correctly", () {
      var orbits = _processOrbits(simple);
      expect(
          orbits,
          equals({
            'aaa': ['bbb'],
            'bbb': ['ccc'],
            'COM': ['ddd'],
            'ddd': ['aaa']
          }));
    });
    test('sample input', () {
      expect(_tallyAllOrbits(_processOrbits(sampleInput)), equals(42));
    });
  });

  group('part two', () {
    test('_processOrbitsUndirected simple', () {
      expect(
          _processOrbitsUndirected(simple),
          equals({
            'COM': {'ddd'},
            'ddd': {'COM', 'aaa'},
            'aaa': {'ddd', 'bbb'},
            'bbb': {'aaa', 'ccc'},
            'ccc': {'bbb'}
          }));
    });
    var pt2SampleInput = sampleInput + ['xxK)YOU', 'xxI)SAN'];
    test('sample input', () {
      expect(_minimumTransfers(_processOrbitsUndirected(pt2SampleInput)),
          equals(4));
    });
  });
}
