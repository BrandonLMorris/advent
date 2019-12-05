import 'dart:io';

const inputFile = "input/day1.txt";
final file = new File(inputFile);
final lines = file.readAsLinesSync();

int main() {
  partOneMain();
  partTwoMain();
}

void partOneMain() {
  var transformed = lines.map((x) => calcFuelRequired(int.parse(x)));
  print(transformed.reduce((x, y) => x + y));
}

void partTwoMain() {
  var requirements = lines.map((x) => calcAllFuelRequired(int.parse(x)));
  print(requirements.reduce((x, y) => x + y));
}

// TODO: Could memoize for maximum efficiency
int calcAllFuelRequired(int module) {
  int sum = 0;
  int fuel = calcFuelRequired(module);
  while (fuel > 0) {
    sum += fuel;
    fuel = calcFuelRequired(fuel);
  }
  return sum;
}

int calcFuelRequired(int module) {
  int res = (module ~/ 3) - 2;
  return res > 0 ? res : 0;
}
