import 'package:test/test.dart';

import '../lib/src/day1.dart';

const sample = ["1721", "979", "366", "299", "675", "1456"];

void main() {
  group('part one', () {
    test('sample input', () {
      expect(findEntryPair(sample.map((x) => int.parse(x)).toList()), 514579);
    });

    test('bad input', () {
      // Doesn't have a pair that adds to 2020
      expect(findEntryPair([1, 2, 3, 4, 5]), -1);
    });
  });

  group('part two', () {
    test('sample input', () {
      expect(findEntryTriple(sample.map((x) => int.parse(x)).toList()), 241861950);
    });

    test('bad input', () {
      // Doesn't have a pair that adds to 2020
      expect(findEntryTriple([1, 2, 3, 4, 5]), -1);
    });
  });
}
