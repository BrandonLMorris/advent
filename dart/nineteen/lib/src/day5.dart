import 'advent_day.dart';
import 'intcomp.dart';

class DayFive implements AdventDay {
  int dayNum = 5;
  void partOne(List<String> lines) => _partOne(lines);
  void partTwo(List<String> lines) => _partTwo(lines);
}

void _partOne(List<String> lines) {
  List<int> tape = lines[0].split(',').map((x) => int.parse(x)).toList();
  List<int> output = runProgram(List<int>.from(tape), [1]);
  print('Part 1: ${output.last} (Expected 7988899 for my input)');
}

void _partTwo(List<String> lines) {
  List<int> tape = lines[0].split(',').map((x) => int.parse(x)).toList();
  List<int> output = runProgram(List<int>.from(tape), [5]);
  print('Part 2: ${output.last} (Expected 13758663 for my input)');
}

