import 'advent_day.dart';
import 'package:test/test.dart';
import 'intcomp.dart';

class DaySeven implements AdventDay {
  int dayNum = 7;

  void partOne(List<String> lines) => _partOne(lines);

  void partTwo(List<String> lines) => _partTwo(lines);

  void runAllTests() => _runAllTests();
}

void _partOne(List<String> lines) {
  List<int> program = lines[0].split(',').map((x) => int.parse(x)).toList();
  print('${_largestOutput(program)} (expect to be 99376 for my input)');
}

void _partTwo(List<String> lines) {
  print('TODO');
}

int _largestOutput(List<int> program) {
  var largest;
  for (var permutation in _permutations([0, 1, 2, 3, 4])) {
    var out =
        _outputSignalForPhaseSettings(permutation, List<int>.from(program));
    if (largest == null || out > largest) {
      largest = out;
    }
  }
  return largest;
}

int _outputSignalForPhaseSettings(List<int> settings, List<int> program) {
  if (settings.length != 5 || !settings.toSet().containsAll({0, 1, 2, 3, 4})) {
    print('ERROR: Invalid phase settings. Should include 0-4; got $settings');
    return -1;
  }
  int inputSignal = 0;
  for (var phaseSetting in settings) {
    List<int> output =
        runProgram(List<int>.from(program), [phaseSetting, inputSignal]);
    inputSignal = output[0];
  }
  // The last 'input' signal is the amplifier's output
  return inputSignal;
}

Set<List<int>> _permutations(List<int> lst) {
  if (lst.length == 0) return {};
  if (lst.length == 1)
    return {
      [lst.first]
    };
  Set<List<int>> perms = {};
  for (var i = 0; i < lst.length; i++) {
    var current = lst[i];
    List<int> remList = List<int>.from(lst.getRange(0, i)) +
        List<int>.from(lst.getRange(i + 1, lst.length));
    for (List<int> perm in _permutations(remList)) {
      perms.add([current] + perm);
    }
  }
  return perms;
}

void _runAllTests() {
  group('part one', () {
    test('bad phase settings errors', () {
      expect(_outputSignalForPhaseSettings([4, 4, 4, 4], []), equals(-1));
    });

    test('_permuations small input', () {
      expect(
          _permutations([1, 2, 3]),
          equals({
            [1, 2, 3],
            [1, 3, 2],
            [2, 1, 3],
            [2, 3, 1],
            [3, 1, 2],
            [3, 2, 1]
          }));
    });

    test('sample input 1', () {
      var phaseSetting = [4, 3, 2, 1, 0];
      var program = [
        3,
        15,
        3,
        16,
        1002,
        16,
        10,
        16,
        1,
        16,
        15,
        15,
        4,
        15,
        99,
        0,
        0
      ];
      expect(_largestOutput(program), equals(43210));
    });

    test('sample input 2', () {
      var program = [
        3,
        23,
        3,
        24,
        1002,
        24,
        10,
        24,
        1002,
        23,
        -1,
        23,
        101,
        5,
        23,
        23,
        1,
        24,
        23,
        23,
        4,
        23,
        99,
        0,
        0
      ];
      expect(_largestOutput(program), equals(54321));
    });

    test('sample input 3', () {
      var program = [3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,
        1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0];
      expect(_largestOutput(program), equals(65210));
    });
  });
}
