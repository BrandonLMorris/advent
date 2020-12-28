import 'advent_day.dart';

class DayTwo implements AdventDay {
  int dayNum = 1;
  void partOne(List<String> lines) => _partOne(lines);
  void partTwo(List<String> lines) => _partTwo(lines);
}

void _partOne(List<String> input) {
  print(input
      .map((line) => parse(line).isValid() ? 1 : 0)
      .reduce((x, y) => x + y));
}

void _partTwo(List<String> input) {
  print(input
      .map((line) => parse(line).isPositionallyValid() ? 1 : 0)
      .reduce((x, y) => x + y));
}

class ParsedLine {
  final String letter;
  final int minOccurances;
  final int maxOccurances;
  final String password;
  ParsedLine(
      this.letter, this.minOccurances, this.maxOccurances, this.password);

  bool isValid() {
    int occurances = countOccurances(letter, password);
    return occurances >= minOccurances && occurances <= maxOccurances;
  }

  bool isPositionallyValid() {
    // minOccurances -> first one-based index
    // maxOccurances -> second one-based index
    // Exactly one (not both) must be the target letter
    bool firstIndex = password[minOccurances - 1] == letter;
    bool secondIndex = password[maxOccurances - 1] == letter;
    return (firstIndex || secondIndex) && !(firstIndex && secondIndex);
  }
}

ParsedLine parse(String line) {
  // Example
  // 1-3 a: abcde
  var regex = RegExp(r"(\d+)-(\d+) ([a-z]): ([a-z]+)");
  var match = regex.firstMatch(line);
  return ParsedLine(match.group(3), int.parse(match.group(1)),
      int.parse(match.group(2)), match.group(4));
}

bool isValid(ParsedLine parsedLine) {
  int occurances = countOccurances(parsedLine.letter, parsedLine.password);
  return occurances >= parsedLine.minOccurances &&
      occurances <= parsedLine.maxOccurances;
}

int countOccurances(String toFind, String searchString) {
  return searchString
      .split('')
      .map((c) => c == toFind ? 1 : 0)
      .reduce((x, y) => x + y);
}
