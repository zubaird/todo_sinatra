class Todos
  attr_accessor :input, :output

  def initialize(input, output)
    self.input = input
    self.output = output
  end

  def puts message
    output.puts message
  end

  def gets
    input.gets
  end

  def run
    # YOUR CODE HERE -----
  end
end
