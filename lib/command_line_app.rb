class CommandLineApp
  attr_reader :input, :output

  def puts(message = "")
    output.puts(message)
  end

  def gets
    input.gets
  end

  def real_puts message = ""
    $stdout.puts message
  end

  def initialize(input, output)
    @input = input
    @output = output
  end
end
