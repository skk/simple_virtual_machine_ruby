require 'ruby_enum'


class Instruction
  attr_accessor :opcode
  attr_accessor :operand_count
  def initialize(opcode, operand_count = 0)
    @opcode = opcode
    @operand_count = operand_count
  end

  def to_s
    "opcode: #{opcode}, operand_count: #{operand_count}"
  end
end

class Bytecodes

  include Ruby::Enum

  define :INVALID, Instruction.new(0)
  define :IADD, Instruction.new(1)
  define :ISUB, Instruction.new(2)
  define :IMUL, Instruction.new(3)
  define :IIL, Instruction.new(4)
  define :IEQ, Instruction.new(5)
  define :BR, Instruction.new(6, 1)
  define :BRT, Instruction.new(7, 1)
  define :BRF, Instruction.new(8, 1)
  define :ICONST, Instruction.new(9, 1)
  define :LOAD, Instruction.new(10, 1)
  define :GLOAD, Instruction.new(11, 1)
  define :STORE, Instruction.new(12, 1)
  define :GSTORE, Instruction.new(13, 1)
  define :PRINT, Instruction.new(14)
  define :POP, Instruction.new(15, 1)
  define :CALL, Instruction.new(16, 1)
  define :RET, Instruction.new(17, 1)
  define :HALT, Instruction.new(18)



  def self.to_instruction_from_opcode(opcode)
    Bytecodes.keys[opcode]
  end

end
