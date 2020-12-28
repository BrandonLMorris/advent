import 'advent_day.dart';
import 'advent_day.dart';

class DayOne implements AdventDay {
  int dayNum = 1;
  void partOne(List<String> lines) => _partOne(lines);
  void partTwo(List<String> lines) => _partTwo(lines);
}

void _partOne(List<String> lines) {
  int result = findEntryPair(lines.map((x) => int.parse(x)).toList());
  if (result == -1) {
    throw 'Input list does not contain a result!';
  }
  print(result);
}

void _partTwo(List<String> lines) {
  int result = findEntryTriple(lines.map((x) => int.parse(x)).toList());
  if (result == -1) {
    throw 'Input list does not contain a result!';
  }
  print(result);
}

int findEntryPair(List<int> ints) {
  for (var i = 0; i < ints.length; i++) {
    for (var j = i + 1; j < ints.length; j++) {
      if (ints[i] + ints[j] == 2020) {
        return ints[i] * ints[j];
      }
    }
  }
  return -1;
}

int findEntryTriple(List<int> ints) {
  for (var i = 0; i < ints.length; i++) {
    for (var j = i + 1; j < ints.length; j++) {
      for (var k = j + 1; k < ints.length; k++) {
        if (ints[i] + ints[j] + ints[k] == 2020) {
          return ints[i] * ints[j] * ints[k];
        }
      }
    }
  }
  return -1;
}
