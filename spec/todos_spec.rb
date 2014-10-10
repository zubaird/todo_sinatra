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

  describe "quitting" do
    describe "when the input is quit" do
      it "the program exits" do
        expect(io_input).to receive(:gets).and_return('exit')
        cli.run
      end
    end

    describe "when the input is something else" do
      xit "asks for more input" do
      end
    end
  end
end
