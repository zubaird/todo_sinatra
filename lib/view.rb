class View
  attr_reader :output, :input
  def initialize(output, input)
    @output = output
    @input = input
  end

  def get_input
    input.gets.chomp
  end

  def print_project_menu
    puts "Welcome"
    puts "'list' to list projects"
    puts "'create' to create a new project"
    puts "'edit' to edit a project"
    puts "'rename' to rename a project"
    puts "'delete' to rename a project"
  end

  def print_task_menu(project_name)
    puts "Editing Project: #{project_name} "
    puts "'list' to list tasks"
    puts "'create' to create a new task"
    puts "'edit' to edit a task"
    puts "'complete' to complete a task and remove it from the list"
  end

  def print_projects_list(projects)
    puts "Projects:"
    if projects.empty?
      puts "  none"
    else
      puts "  #{projects.join(', ')}"
    end
  end

  def print_tasks_list(tasks)
    puts "Tasks:"
    if tasks.empty?
      puts "  none"
    else
      puts "  #{tasks.join(', ')}"
    end
  end

  def print_project_create_prompt
    puts "Please enter the new project name:\n"
  end

  # V, printer
  def print_project_delete_prompt
    puts "Please enter the project name to delete:\n"
  end

  def print_project_rename_prompt
    puts "Please enter the project name to rename:\n"
  end

  def print_prompt_for_new_project_name
    puts "Please enter the new project name:\n"
  end

  def print_project_edit_prompt
    puts "Which project would you like to edit?\n"
  end

  def print_task_edit_prompt
    puts "Please enter the task you would like to edit."
  end

  def print_prompt_for_new_task_name
    puts "Please enter the new task name:\n"
  end

  def print_new_task_prompt
    puts "Please enter the task you would like to add."
  end

  def print_task_not_here_message(name)
    puts "task not found: '#{name}'"
  end

  def puts(message)
    output.puts(message)
  end
end
