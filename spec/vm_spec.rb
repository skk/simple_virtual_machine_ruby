require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'vm'

describe "minimal vm" do
  it "create minimal vm" do
    vm = VM.new([])
  end
end
