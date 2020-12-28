import 'package:test/test.dart';

import '../lib/src/day2.dart';

void main() {
  group('part one', () {
    test('parsed line is valid', () {
      expect(ParsedLine('a', 1, 3, 'aaa').isValid(), true);
    });

    test('parsed line is invalid', () {
      expect(ParsedLine('b', 1, 3, 'aaa').isValid(), false);
    });

    test('parsed line too many invalid', () {
      expect(ParsedLine('a', 1, 3, 'aaaa').isValid(), false);
    });
  });

  group('part two', () {
    test('parsed line is positionally valid', () {
      expect(ParsedLine('a', 1, 3, 'abcde').isPositionallyValid(), true);
    });

    test('parsed line is positionally invalid; no characters match', () {
      expect(ParsedLine('b', 1, 3, 'cdefg').isPositionallyValid(), false);
    });

    test('parsed line is positionally invalid; both characters match', () {
      expect(ParsedLine('c', 2, 9, 'ccccccccc').isPositionallyValid(), false);
    });
  });
}