require 'spec_helper'

describe Todos, "#run" do
  let(:io_input)  { StringIO.new("") }
  let(:io_output) { StringIO.new("") }

  let(:cli) { Todos.new(io_input, io_output) }

  describe "Introductory text" do
    let(:output) { io_output.string }

    before do
      allow(io_input).to receive(:gets) { "" }
      cli.run
    end

    it "includes 'Welcome'" do
      expect( output ).to include("Welcome")
    end
  end
end
