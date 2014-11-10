class TodoApp < CommandLineApp
  def initialize(input, output)
    @input = input
    @output = output

  end

  def run
    projects = "none"
    puts "Welcome"
    puts "'list' to list projects"
    puts "'create' to create a new project"
    puts "'edit' to edit a project"

    input = gets.chomp

    while input != 'quit'
      if input == 'list'
        puts "Projects:\n  #{projects} "
      end
      if input == 'create'
        puts "Please enter the new project name:\n"
        projects = gets.chomp
      end
      if input == 'edit'
        puts "Please enter the project name to edit:\n"
        edit_project = gets.chomp
        if edit_project == projects
          puts "Please enter the new project name:\n"
          projects = gets.chomp
        end
      end
      if input == 'delete'
        puts "Please enter the project name to delete:\n"
        delete_project = gets.chomp
        if delete_project == projects
          projects = "none"
        end
      end
      input = gets.chomp
    end
  end

  def real_puts message = ""
    $stdout.puts message
  end
end
