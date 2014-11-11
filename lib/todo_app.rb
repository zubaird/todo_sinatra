class TodoApp < CommandLineApp
  def initialize(input, output)
    @input = input
    @output = output
    @projects = []
    @tasks = []
  end

  def run
    puts "Welcome"
    puts "'list' to list projects"
    puts "'create' to create a new project"
    puts "'edit' to edit a project"
    puts "'rename' to rename a project"

    welcome_menu = true


    while welcome_menu
      input = gets.chomp
      if input == 'list'
        puts "Projects:\n  #{print_projects} "

      elsif input == 'create'
        puts "Please enter the new project name:\n"
        create_project = gets.chomp
        @projects << create_project
        run

      elsif input == 'delete'
        puts "Please enter the project name to delete:\n"
        delete_project = gets.chomp
        if @projects.include?(delete_project)
          @projects.delete(delete_project)
        end

      elsif input == 'rename'
        puts "Please enter the project name to rename:\n"
        rename_project = gets.chomp
        if @projects.include?(rename_project)
          puts "Please enter the new project name:\n"
          new_project_name = gets.chomp
          @projects.delete(rename_project)
          @projects << new_project_name
        end

      elsif input == 'edit'
        puts "Which project would you like to edit?\n"
        puts "Projects:\n  *#{print_projects} "
        edit_project = gets.chomp
        if @projects.include?(edit_project)
          puts "Editing Project: #{print_projects} "
          puts "'list' to list tasks"
          puts "'create' to create a new task"
          puts "'edit' to edit a task"
          puts "'complete' to complete a task and remove it from the list"


          task_menu = true
          while task_menu
            task_input = gets.chomp
            if task_input == 'list'
              puts "  #{list_tasks}"
            elsif task_input == 'create'
              puts "Please enter the task you would like to add."
              new_task = gets.chomp
              @tasks << new_task
            elsif task_input == 'edit'
              puts "Please enter the task you would like to edit."
              edit_task = gets.chomp
              if @tasks.include?(edit_task)
                puts "Please enter the new task name:\n"
                new_task_name = gets.chomp
                @tasks.delete(edit_task)
                @tasks << new_task_name
              else
                puts "task not found: 'not here'"
              end
            elsif task_input == 'complete'
              puts "Which task have you completed?"
              puts "  #{list_tasks}"
              complete_task = gets.chomp
              if @tasks.include?(complete_task)
                @tasks.delete(complete_task)
                complete_task = "#{complete_task}: completed"
                @tasks << complete_task
              else
                puts "task not found: 'not here'"
              end
            elsif task_input == 'back'
              run
              task_menu = false
            elsif task_input == 'quit'
              welcome_menu = false
              task_menu = false
            end
          end
        end

      elsif input == 'quit'
        welcome_menu = false
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
