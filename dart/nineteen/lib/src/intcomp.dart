enum ParamMode { immediate, position }
enum OpType {
  add,
  mul,
  print,
  input,
  halt,
  jumpTrue,
  jumpFalse,
  lessThan,
  equals
}
const codeToType = {
  1: OpType.add,
  2: OpType.mul,
  3: OpType.input,
  4: OpType.print,
  5: OpType.jumpTrue,
  6: OpType.jumpFalse,
  7: OpType.lessThan,
  8: OpType.equals,
  99: OpType.halt
};
const codeToNumberParameters = {
  1: 3,
  2: 3,
  3: 1,
  4: 1,
  5: 2,
  6: 2,
  7: 3,
  8: 3,
  99: 0
};

class Operation {
  final OpType type;
  final List<ParamMode> paramModes;
  Operation(this.type, this.paramModes);
}

List<int> runProgram(List<int> tape, List<int> inputs) {
  var ip = 0;
  List<int> outputs = [];
  while (ip >= 0) {
    ip = apply(ip, tape, inputs, outputs);
  }
  return outputs;
}

// Apply the operation to the tape and return the new pointer
int apply(int ip, List<int> tape, List<int> inputs, List<int> output) {
  Operation op = parseOpcode(tape[ip]);
  switch (op.type) {
    case OpType.add:
    case OpType.mul:
      int x = tape[ip + 1];
      if (op.paramModes[0] == ParamMode.position) {
        x = tape[x];
      }
      int y = tape[ip + 2];
      if (op.paramModes[1] == ParamMode.position) {
        y = tape[y];
      }
      tape[tape[ip + 3]] = op.type == OpType.add ? x + y : x * y;
      return ip + 4;
    case OpType.print:
      output.add(tape[tape[ip + 1]]);
      return ip + 2;
    case OpType.input:
      tape[tape[ip + 1]] = inputs.removeAt(0);
      return ip + 2;
    case OpType.jumpTrue:
    case OpType.jumpFalse:
      int test = tape[ip + 1];
      if (op.paramModes[0] == ParamMode.position) {
        test = tape[test];
      }
      if ((op.type == OpType.jumpTrue && test != 0) ||
          (op.type == OpType.jumpFalse && test == 0)) {
        // Do the jump
        int dest = tape[ip + 2];
        if (op.paramModes[1] == ParamMode.position) dest = tape[dest];
        return dest;
      }
      return ip + 3;
    case OpType.lessThan:
    case OpType.equals:
      int first = tape[ip + 1];
      if (op.paramModes[0] == ParamMode.position) first = tape[first];
      int second = tape[ip + 2];
      if (op.paramModes[1] == ParamMode.position) second = tape[second];
      int dest = tape[ip + 3];
      if ((op.type == OpType.lessThan && first < second) ||
          (op.type == OpType.equals && first == second)) {
        tape[dest] = 1;
      } else {
        tape[dest] = 0;
      }
      return ip + 4;
    case OpType.halt:
      return -1;
  }
}

Operation parseOpcode(int opcode) {
  var type = codeToType[opcode % 100];
  String opcodeStr = opcode.toString();
  List<ParamMode> modes = [];
  for (int i = opcodeStr.length - 3; i >= 0; i--) {
    modes.add(opcodeStr[i] == '0' ? ParamMode.position : ParamMode.immediate);
  }
  // Pad any missing modes
  while (modes.length < codeToNumberParameters[opcode % 100])
    modes.add(ParamMode.position);
  return Operation(type, modes);
}
