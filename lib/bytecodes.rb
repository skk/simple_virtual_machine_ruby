require 'ruby_enum'

class Bytecodes

  include Ruby::Enum

  define :INVALID, 0
  define :IADD, 1
  define :ISUB, 2
  define :IMUL, 3
  define :IIL, 4
  define :IEQ, 5
  define :BR, 6
  define :BRT, 7
  define :BRF, 8
  define :ICONST, 9
  define :LOAD, 10
  define :GLOAD, 11
  define :STORE, 12
  define :GSTORE, 13
  define :PRINT, 14
  define :POP, 15
  define :CALL, 16
  define :RET, 17
  define :HALT, 18

end
