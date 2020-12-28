import 'package:test/test.dart';
// import 'package:advent/src/day1.dart';

import '../lib/src/day1.dart';

const sample = ["1721", "979", "366", "299", "675", "1456"];

void main() {
  group('part one', () {
    test('sample input', () {
      expect(514579, findEntryPair(sample.map((x) => int.parse(x)).toList()));
    });

    test('bad input', () {
      // Doesn't have a pair that adds to 2020
      expect(-1, findEntryPair([1, 2, 3, 4, 5]));
    });
  });

  group('part two', () {
    test('sample input', () {
      expect(241861950, findEntryTriple(sample.map((x) => int.parse(x)).toList()));
    });

    test('bad input', () {
      // Doesn't have a pair that adds to 2020
      expect(-1, findEntryTriple([1, 2, 3, 4, 5]));
    });
  });
}
