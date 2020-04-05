import 'package:test/test.dart';
import 'package:advent/src/day4.dart';

void main() {
  group('part one', () {
    test('sample inputs', () {
      expect(isValidPassword(111111), equals(true));
      expect(isValidPassword(223450), equals(false));
      expect(isValidPassword(123789), equals(false));
    });
  });

  group('part two', () {
    test('sample inputs', () {
      expect(adjacentNotInLargerGroup('111122'), equals(true));
      expect(adjacentNotInLargerGroup('112233'), equals(true));
      expect(adjacentNotInLargerGroup('123444'), equals(false));
    });
  });

  List<String> trueInputs = ['001111', '100111', '110011', '111001', '111100'];
  for (var input in trueInputs) {
    test('$input should be true', () {
      expect(adjacentNotInLargerGroup(input), equals(true));
    });
  }
  List<String> falseInputs = ['111000', '011101', '000101'];
  for (var input in falseInputs) {
    test('$input should be false', () {
      expect(adjacentNotInLargerGroup(input), equals(false));
    });
  }
}
