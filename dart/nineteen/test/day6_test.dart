import 'package:test/test.dart';
import 'package:advent/src/day6.dart';

void main() {
  // com - ddd - aaa - bbb - ccc
  var simple = ['aaa)bbb', 'bbb)ccc', 'COM)ddd', 'ddd)aaa'];
  // com - aaa - bbb - ccc
  //          \ eee - fff
  var branched = ['COM)aaa', 'aaa)bbb', 'bbb)ccc', 'aaa)eee', 'eee)fff'];
  var sampleInput = [
    'COM)xxB',
    'xxB)xxC',
    'xxC)xxD',
    'xxD)xxE',
    'xxE)xxF',
    'xxB)xxG',
    'xxG)xxH',
    'xxD)xxI',
    'xxE)xxJ',
    'xxJ)xxK',
    'xxK)xxL',
  ];
  group('part one', () {
    test("processes orbits correctly", () {
      var orbits = processOrbits(simple);
      expect(
          orbits,
          equals({
            'aaa': ['bbb'],
            'bbb': ['ccc'],
            'COM': ['ddd'],
            'ddd': ['aaa']
          }));
    });
    test('sample input', () {
      expect(tallyAllOrbits(processOrbits(sampleInput)), equals(42));
    });
  });

  group('part two', () {
    test('processOrbitsUndirected simple', () {
      expect(
          processOrbitsUndirected(simple),
          equals({
            'COM': {'ddd'},
            'ddd': {'COM', 'aaa'},
            'aaa': {'ddd', 'bbb'},
            'bbb': {'aaa', 'ccc'},
            'ccc': {'bbb'}
          }));
    });
    var pt2SampleInput = sampleInput + ['xxK)YOU', 'xxI)SAN'];
    test('sample input', () {
      expect(minimumTransfers(processOrbitsUndirected(pt2SampleInput)),
          equals(4));
    });
  });
}