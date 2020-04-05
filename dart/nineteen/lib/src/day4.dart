import 'advent_day.dart';

class DayFour implements AdventDay {
  int dayNum = 4;
  void partOne(List<String> lines) => print(_getSolution(lines)[0]);
  void partTwo(List<String> lines) => print(_getSolution(lines)[1]);
}

List<int> _getSolution(List<String> lines) {
  final int start = int.parse(lines[0]);
  final int end = int.parse(lines[1]);
  int count = 0;
  int count2 = 0;
  for (int pass = start; pass <= end; pass++) {
    if (isValidPassword(pass)) {
      count++;
      // For part 2, check the additional requirement
      if (adjacentNotInLargerGroup(pass.toString())) {
        count2++;
      }
    }
  }
  return [count, count2];
}

// Checks validity on everything *except the range requirement*
bool isValidPassword(int password) {
  String strpass = password.toString();
  if (strpass.length != 6) return false;
  return containsIdenticalAdjacent(strpass) && nonDecreasingDigits(strpass);
}

bool containsIdenticalAdjacent(String password) {
  for (int i = 0; i < password.length - 1; i++) {
    if (password[i] == password[i + 1]) {
      return true;
    }
  }
  return false;
}

bool nonDecreasingDigits(String password) {
  for (int i = 0; i < password.length - 1; i++) {
    if (int.parse(password[i]) > int.parse(password[i + 1])) {
      return false;
    }
  }
  return true;
}

bool adjacentNotInLargerGroup(String password) {
  for (int i = 0; i < password.length - 1; i++) {
    if (password[i] == password[i + 1]) {
      // Potential match; need to check there isn't another on each side
      if (i > 0 && password[i - 1] == password[i]) continue;
      if (i + 2 < password.length && password[i + 2] == password[i]) continue;
      return true;
    }
  }
  return false;
}
