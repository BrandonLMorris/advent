import 'advent.dart';

class DayOne implements AdventDay {
  int dayNum = 1;
  void partOne(List<String> lines) => _partOne(lines);
  void partTwo(List<String> lines) => _partTwo(lines);
  void runAllTests() {}
}

void _partOne(List<String> lines) {
  var transformed = lines.map((x) => _calcFuelRequired(int.parse(x)));
  print(transformed.reduce((x, y) => x + y));
}

void _partTwo(List<String> lines) {
  var requirements = lines.map((x) => _calcAllFuelRequired(int.parse(x)));
  print(requirements.reduce((x, y) => x + y));
}

// TODO: Could memoize for maximum efficiency
int _calcAllFuelRequired(int module) {
  int sum = 0;
  int fuel = _calcFuelRequired(module);
  while (fuel > 0) {
    sum += fuel;
    fuel = _calcFuelRequired(fuel);
  }
  return sum;
}

int _calcFuelRequired(int module) {
  int res = (module ~/ 3) - 2;
  return res > 0 ? res : 0;
}
