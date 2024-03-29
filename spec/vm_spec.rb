require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'vm'
require 'bytecodes'
require 'pp'

VM.tracing = true

describe 'VM tests:' do
  it 'should halt' do
    vm = VM.new([Bytecodes::HALT])
    rv = vm.exec
    expect(rv.opcode).to eq(Bytecodes::HALT.opcode)
  end

  context 'it should load and halt' do
    vm = VM.new([Bytecodes::ICONST, 100, Bytecodes::HALT])
    rv = vm.exec

    it 'should load 100' do
      expect(vm.stack[vm.sp]).to eq(100)
    end

    it 'and halt' do
      expect(rv).to eq(Bytecodes::HALT)
    end
  end

  context 'it should load 2 constants and halt' do
    vm = VM.new([Bytecodes::ICONST, 1, Bytecodes::ICONST, 2, Bytecodes::HALT])
    rv = vm.exec
    # puts "VM #{vm}"

    it 'should load 1 and 2' do
      expect(vm.stack[vm.sp - 1]).to eq(1)
      expect(vm.stack[vm.sp]).to eq(2)
    end

    it 'and halt' do
      expect(rv).to eq(Bytecodes::HALT)
    end
  end

  context 'it should load 2 constants, print and halt' do
    vm = VM.new([Bytecodes::ICONST, 1, Bytecodes::ICONST, 2,
                 Bytecodes::PRINT,
                 Bytecodes::HALT])
    rv = vm.exec

    it 'should load 1 and 2, ' do
      expect(vm.stack[vm.sp - 2]).to eq(1)
      expect(vm.stack[vm.sp - 1]).to eq(2)
    end

    it 'print ' do
      expect(vm.code).to include(Bytecodes::PRINT)
    end

    it 'and halt' do
      expect(rv).to eq(Bytecodes::HALT)
    end
  end

end
