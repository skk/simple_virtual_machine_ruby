
class VM

  attr_accessor :ip
  attr_accessor :code
  attr_accessor :datasize

  def initialize(code, ip = 0, datasize = 100)
    @code, @ip, @datasize = code, ip, Array.new(datasize)
  end


end
