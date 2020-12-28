import 'dart:io';
import 'package:args/args.dart';
import 'package:advent/src/advent_day.dart';

const partOp = "part";
const dayOp = "day";

int main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption(partOp, abbr: 'p')
    ..addOption(dayOp, abbr: 'd');
  var argResult = parser.parse(arguments);

  int dayNum = _getDayFromArgs(argResult);
  AdventDay day = AdventDay(dayNum);
  if (day == null) exit(-1);
  var input = _getInput(dayNum);
  _runPartsSpecified(argResult, day, input);
}

// Parse the command line args to retrieve the day number.
int _getDayFromArgs(ArgResults args) {
  String numStr = args[dayOp];
  if (numStr == null) {
    print('ERROR: Must specify a day');
    exit(-1);
  }
  int dayNum = int.tryParse(numStr);
  if (dayNum == null) {
    print('ERROR: Must specify a day as an integer. Got $numStr');
    exit(-1);
  }
  return dayNum;
}

// Gather the input for a particular day.
List<String> _getInput(int dayNum) {
  var file = File('input/day${dayNum}.txt');
  return file.readAsLinesSync();
}

void _runPartsSpecified(ArgResults args, AdventDay day, List<String> input) {
  var partSpecified = args[partOp];
  if (partSpecified == null) {
    print('No part specified; running all parts');
    day.partOne(input);
    day.partTwo(input);
    return;
  }
  switch (partSpecified) {
    case '1':
      day.partOne(input);
      break;
    case '2':
      day.partTwo(input);
      break;
    default:
      print('ERROR: Invalid part specified. Expected 1, 2, or nothing; got '
          '$partSpecified');
      exit(-1);
  }
}
