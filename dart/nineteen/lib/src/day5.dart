import 'package:test/test.dart';
import 'advent_day.dart';
import 'intcomp.dart';

class DayFive implements AdventDay {
  int dayNum = 5;
  void partOne(List<String> lines) => _partOne(lines);
  void partTwo(List<String> lines) => _partTwo(lines);
  void runAllTests() => _runAllTests();
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


// Tests ---------------------------------------------------------------------

void _runAllTests() {
  group('parseOpcode ', () {
    test('works with sample input', () {
      var op = parseOpcode(1002);
      expect(op.type, equals(OpType.mul));
      expect(
          op.paramModes,
          equals(
              [ParamMode.position, ParamMode.immediate, ParamMode.position]));
    });
    test('works with short code', () {
      var op = parseOpcode(3);
      expect(op.type, equals(OpType.input));
      expect(op.paramModes, equals([ParamMode.position]));
    });
  });
  var eq8program = [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8];
  test("sample input", () {
    expect(runProgram(List<int>.from(eq8program), [10]), equals([0]));
    expect(runProgram(List<int>.from(eq8program), [8]), equals([1]));
    expect(runProgram(List<int>.from(eq8program), [6]), equals([0]));
  });
}
