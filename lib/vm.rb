
class VM

  # instruction pointer
  attr_accessor :ip
  # frame pointer
  attr_accessor :fp
  # stack pointer
  attr_accessor :sp

  # code storage
  attr_accessor :code     # aka code
  # data storage
  attr_accessor :data     # aka globals
  # stack storage
  attr_accessor :stack    # aka stack

  attr_accessor :tracing

  at_exit { puts TRACE_OUTPUT.join("") }
  TRACE_OUTPUT = []

  $TracingGlobally = false

  def initialize(code, ip = 0, datasize = 0)
    @code = code
    @ip = ip
    @fp = 0
    @sp = -1
    @data = Array.new()
    @stack = Array.new()
    @tracing = false
    trace { ("-" * 60) + "\n" }
    #trace { self }
  end


  def self.disable_tracking_globally
    $TracingGlobally = false
  end

  def self.enable_tracking_globally
    $TracingGlobally = true
  end


  def trace
    if @tracing || $TracingGlobally
      TRACE_OUTPUT << yield
    end
  end


  def format_instr_or_object(o)
    if o.kind_of?(Instruction)
      Bytecodes.to_instruction_from_opcode(o.opcode)
    else
      "#{o}"
    end
  end


  def to_s
    buf = "FP #{fp}, IP #{ip}, SP #{sp},\nDATA #{data},\nSTACK #{stack},\nCODE ["
    buf << code.map { |k| format_instr_or_object(k) }.join(", ")
    buf << "]"
    buf
  end

  def exec

    # fetch opcode
    opcode = code[ip]

    while opcode != Bytecodes::HALT && ip <= code.length

      trace { display_instruction }
      @ip += 1

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
        puts v.to_s
        trace { v.to_s }
      # when Bytecodes::POP
      # when Bytecodes::CALL
      # when Bytecodes::RET
      when Bytecodes::HALT
        # pass
      else
        rv = Bytecodes::INVALID
        raise "Invalid opcode #{opcode} at ip = #{ip-1}"
      end

      trace { dump_stack }
      trace { "\n" }
      opcode = code[ip]
    end

    trace { display_instruction }
    trace { dump_stack }
    trace { "\n" }
    trace { dump_data_memory }
    trace { dump_code_memory }

    Bytecodes::HALT
  end


  def display_instruction
    opcode = code[ip]

    if (opcode.operand_count > 0)
      start_idx = ip+1
      end_idx = ip+opcode.operand_count
      operands = (start_idx..end_idx).map { |idx| code[idx] }.join(", ")
    end

    sprintf("%04d: %-10s %-10s",
      ip, Bytecodes.to_instruction_from_opcode(opcode.opcode), operands)
  end

  def dump_stack
    sprintf("\t%-10s", "stack=[ " + stack.map { |s| s }.join(", ") + " ]")
  end

  def dump_data_memory
    addr = -1
    buf = "Data memory:\n"
    data.each do |d|
      addr += 1
      buf << sprintf("%04d: %s\n", addr, d)
    end
    buf + "\n"
  end

  def dump_code_memory
    addr = 0
    buf = "Code memory:\n"
    code.each do |c|
      buf << sprintf("%04d: %s\n", addr, format_instr_or_object(c))
      addr += 1
    end
    buf + "\n"
  end


end
