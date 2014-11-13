class TodoApp < CommandLineApp
  attr_reader :projects, :tasks

  def initialize(input, output)
    @input = input
    @output = output
    @projects = []
    @tasks = []
  end

  def get_input
    gets.chomp
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

  def print_task_not_here_message(name)
    puts "task not found: '#{name}'"
  end

  def print_new_task_prompt
    puts "Please enter the task you would like to add."
  end

  def project_add(name)
    projects << name
  end

  def project_delete(name)
    if project_present?(name)
      projects.delete(name)
    end
  end

  def project_present?(name)
    projects.include?(name)
  end

  def project_rename(old_name, new_name)
    projects.delete(old_name)
    projects << new_name
  end

  def add_task(name)
    tasks << name
  end

  def task_present?(name)
    tasks.include?(name)
  end

  def task_rename(old_name, new_name)
    tasks.delete(old_name)
    tasks << new_name
  end

  def complete_task(name)
    tasks.delete(name)
    completed_task = "#{name}: completed"
    tasks << completed_task
  end

  def run
    print_project_menu

    welcome_menu = true

    while welcome_menu
      input = get_input

      if input == 'list'
        print_projects_list(projects)
      elsif input == 'create'
        print_project_create_prompt
        project_add(get_input)
        print_project_menu
      elsif input == 'delete'
        print_project_delete_prompt
        project_delete(get_input)
      elsif input == 'rename'
        print_project_rename_prompt
        if project_present?(old_name = get_input)
          print_prompt_for_new_project_name
          project_rename(old_name, get_input)
        end
      elsif input == 'edit'
        print_project_edit_prompt
        project_name = get_input
        if project_present?(project_name)
          run_task_menu(project_name)
          print_task_menu(project_name)
        end
      elsif input == 'quit'
        welcome_menu = false
      end
    end
  end

  def run_task_menu(project_name)
    print_task_menu(project_name)

    task_menu = true

    while task_menu
      task_input = get_input
      if task_input == 'list'
        print_tasks_list(tasks)
      elsif task_input == 'create'
        print_new_task_prompt
        add_task(get_input)
      elsif task_input == 'edit'
        print_task_edit_prompt
        old_name = get_input
        if task_present?(old_name)
          print_prompt_for_new_task_name
          task_rename(old_name, get_input)
        else
          print_task_not_here_message(old_name)
        end
      elsif task_input == 'complete'
        complete_task = get_input
        if task_present?(complete_task)
          complete_task(complete_task)
        else
          print_task_not_here_message(complete_task)
        end
      elsif task_input == 'back'
        print_project_menu
        task_menu = false
      end
    end
  end

  def real_puts message = ""
    $stdout.puts message
  end
end
