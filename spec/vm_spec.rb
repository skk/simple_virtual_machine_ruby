require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'vm'
require 'bytecodes'
require 'pp'

describe "minimal vm" do
  it "create minimal vm" do
    vm = VM.new([])
    vm.cpu
  end
end

describe "VM tests" do
  it "should halt" do
    vm = VM.new([Bytecodes::HALT])
    rv = vm.cpu
    expect(rv).to be == Bytecodes::HALT
  end

  context "it should load, than halt" do
    vm = VM.new([Bytecodes::ICONST, 100, Bytecodes::HALT])
    rv = vm.cpu

    it "should load 100" do
      expect(vm.stack[vm.sp]).to eq(100)
    end

    it "and halt" do
      expect(rv).to eq(Bytecodes::HALT)
    end
  end
end
