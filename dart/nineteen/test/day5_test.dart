import 'package:test/test.dart';
import 'package:advent/src/intcomp.dart';

void main() {
  group('parseOpcode ', () {
    test('works with sample input', () {
      var op = parseOpcode(1002);
      expect(op.type, equals(OpType.mul));
      expect(
          op.paramModes,
          equals(
              [ParamMode.position, ParamMode.immediate, ParamMode.position]));
    });
    test('works with short code', () {
      var op = parseOpcode(3);
      expect(op.type, equals(OpType.input));
      expect(op.paramModes, equals([ParamMode.position]));
    });
  });
  var eq8program = [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8];
  test("sample input", () {
    expect(runProgram(List<int>.from(eq8program), [10]), equals([0]));
    expect(runProgram(List<int>.from(eq8program), [8]), equals([1]));
    expect(runProgram(List<int>.from(eq8program), [6]), equals([0]));
  });
}