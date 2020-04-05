import 'dart:math';
import 'advent_day.dart';

class DaySix implements AdventDay {
  int dayNum = 6;

  void partOne(List<String> lines) => _partOne(lines);

  void partTwo(List<String> lines) => _partTwo(lines);
}

void _partOne(List<String> lines) {
  var orbits = processOrbits(lines);
  print('${tallyAllOrbits(orbits)}');
}

void _partTwo(List<String> lines) {
  var orbits = processOrbitsUndirected(lines);
  print('${minimumTransfers(orbits)}');
}

Map<String, List<String>> processOrbits(List<String> lines) {
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
int tallyAllOrbits(Map<String, List<String>> orbits) {
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

Map<String, Set<String>> processOrbitsUndirected(List<String> lines) {
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
int minimumTransfers(Map<String, Set<String>> orbits) {
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

void _runAllTests() {}
