class TodoApp < CommandLineApp
  def initialize(input, output)
    @input = input
    @output = output
    @projects = []
    @tasks = []
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

  def print_projects_list
    puts "Projects:\n  #{print_projects} "
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

  def project_add(name)
    @projects << name
  end

  def project_delete(name)
    if project_present?(name)
      @projects.delete(name)
    end
  end

  def project_present?(name)
    @projects.include?(name)
  end

  def project_rename(old_name, new_name)
    @projects.delete(old_name)
    @projects << new_name
  end

  def get_input
    gets.chomp
  end

  def run
    print_project_menu

    welcome_menu = true

    while welcome_menu
      input = get_input

      if input == 'list'
        print_projects_list
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
        puts "  #{list_tasks}"
      elsif task_input == 'create'
        puts "Please enter the task you would like to add."
        new_task = get_input
        @tasks << new_task
      elsif task_input == 'edit'
        puts "Please enter the task you would like to edit."
        edit_task = get_input
        if @tasks.include?(edit_task)
          puts "Please enter the new task name:\n"
          new_task_name = get_input
          @tasks.delete(edit_task)
          @tasks << new_task_name
        else
          puts "task not found: 'not here'"
        end
      elsif task_input == 'complete'
        puts "Which task have you completed?"
        puts "  #{list_tasks}"
        complete_task = get_input
        if @tasks.include?(complete_task)
          @tasks.delete(complete_task)
          complete_task = "#{complete_task}: completed"
          @tasks << complete_task
        else
          puts "task not found: 'not here'"
        end
      elsif task_input == 'back'
        print_project_menu
        task_menu = false
      elsif task_input == 'quit'
        welcome_menu = false
        task_menu = false
      end
    end
  end

  def list_tasks
    list_tasks =''
    if @tasks == []
      "none"
    else
      list_tasks = @tasks.each do |name|
         name
      end
      list_tasks.join
    end
  end

  def print_projects
    list_names = ''
    if @projects == []
      "none"
    else
      list_names = @projects.each do |name|
        name
      end
      list_names.join
    end
  end

  def real_puts message = ""
    $stdout.puts message
  end
end
