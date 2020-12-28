import 'day1.dart';
import 'day2.dart';

// Base class for representing day challenges.
abstract class AdventDay {
  int dayNum;

  void partOne(List<String> lines);

  void partTwo(List<String> lines);

  factory AdventDay(int num) {
    var days = [
      DayOne(),
      DayTwo(),
    ];
    if (num > days.length || days[num - 1] == null) {
      print('ERROR: Bad day specified: $num');
      return null;
    }
    return days[num - 1];
  }
}

