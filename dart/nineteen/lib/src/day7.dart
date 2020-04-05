import 'advent_day.dart';
import 'intcomp.dart';

class DaySeven implements AdventDay {
  int dayNum = 7;

  void partOne(List<String> lines) => _partOne(lines);

  void partTwo(List<String> lines) => _partTwo(lines);
}

void _partOne(List<String> lines) {
  List<int> program = lines[0].split(',').map((x) => int.parse(x)).toList();
  print('${largestOutput(program)} (expect to be 99376 for my input)');
}

void _partTwo(List<String> lines) {
  print('TODO');
}

int largestOutput(List<int> program) {
  var largest;
  for (var permutation in permutations([0, 1, 2, 3, 4])) {
    var out =
        outputSignalForPhaseSettings(permutation, List<int>.from(program));
    if (largest == null || out > largest) {
      largest = out;
    }
  }
  return largest;
}

int outputSignalForPhaseSettings(List<int> settings, List<int> program) {
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

Set<List<int>> permutations(List<int> lst) {
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
    for (List<int> perm in permutations(remList)) {
      perms.add([current] + perm);
    }
  }
  return perms;
}
