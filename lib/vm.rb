
class VM

  # instruction pointer
  attr_accessor :ip
  # frame pointer
  attr_accessor :fp
  # stack pointer
  attr_accessor :sp

  # code storage
  attr_accessor :code
  # data storage
  attr_accessor :data
  # stack storage
  attr_accessor :stack

  attr_accessor :tracing

  at_exit { puts TRACE_OUTPUT }

  TRACE_OUTPUT = []

  def initialize(code, ip = 0, datasize = 0)
    @code = code
    @ip = ip
    @fp = 0
    @sp = -1
    @data = Array.new()
    @stack = Array.new()
    @tracing = true
  end

  def trace
    if @tracing
      TRACE_OUTPUT << yield
    end
  end

  def cpu
    while ip <= code.length
      # fetch opcode
      opcode = code[ip]
      @ip += 1

      trace { display_instruction }

      # decode
      case opcode
      # when Bytecodes::IADD
      # when Bytecodes::ISUB
      # when Bytecodes::IMUL
      # when Bytecodes::IIL
      # when Bytecodes::IEQ
      # when Bytecodes::BR
      # when Bytecodes::BRT
      # when Bytecodes::BRF

      when Bytecodes::ICONST
        v = code[ip]
        @ip += 1
        @sp += 1
        @stack[sp] = v
      # when Bytecodes::LOAD
      # when Bytecodes::GLOAD
      # when Bytecodes::STORE
      # when Bytecodes::GSTORE
      when Bytecodes::PRINT
        v = stack[sp]
        @sp -= 1
        puts "val #{v}"
      # when Bytecodes::POP
      # when Bytecodes::CALL
      # when Bytecodes::RET
      when Bytecodes::HALT
        return Bytecodes::HALT
      else
        return Bytecodes::INVALID
      end

      trace { dump_stack }
      opcode = code[ip]
    end

    trace { display_instruction }
    trace { dump_stack }
    trace { dump_data_memory }
  end


  def display_instruction
  end

  def dump_stack
    buf = "stack=["
    (1..sp).each |k|
      buf << " #{k}"
    end

  end

  def dump_data_memory
  end

end
