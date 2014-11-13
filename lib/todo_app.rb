class TodoApp < CommandLineApp
  attr_reader :view, :model

  def initialize(input, output)
    @input = input
    @view = View.new(output)
    # @output = output
    @model = Model.new
  end

  def get_input
    gets.chomp
  end

  def print_project_menu
    # View.new(output).print_project_menu
    view.print_project_menu
  end

  def print_task_menu(project_name)
    # View.new(output).print_task_menu(project_name)
    view.print_task_menu(project_name)
  end

  def print_projects_list(projects)
    # View.new(output).print_projects_list(projects)
    view.print_projects_list(projects)
  end

  def print_tasks_list(tasks)
    # View.new(output).print_tasks_list(tasks)
    view.print_tasks_list(tasks)
  end

  # V, printer
  def print_project_create_prompt
    # View.new(output).print_project_create_prompt
    view.print_project_create_prompt
  end

  # V, printer
  def print_project_delete_prompt
    # View.new(output).print_project_delete_prompt
    view.print_project_delete_prompt
  end

  def print_project_rename_prompt
    # View.new(output).print_project_rename_prompt
    view.print_project_rename_prompt
  end

  def print_prompt_for_new_project_name
    # View.new(output).print_prompt_for_new_project_name
    view.print_prompt_for_new_project_name
  end

  def print_project_edit_prompt
    # View.new(output).print_project_edit_prompt
    view.print_project_edit_prompt
  end

  def print_task_edit_prompt
    # View.new(output).print_task_edit_prompt
    view.print_task_edit_prompt
  end

  def print_prompt_for_new_task_name
    # View.new(output).print_prompt_for_new_task_name
    view.print_prompt_for_new_task_name
  end

  def print_new_task_prompt
    # View.new(output).print_new_task_prompt
    view.print_new_task_prompt
  end

  def print_task_not_here_message(name)
    # View.new(output).print_task_not_here_message(name )
    view.print_task_not_here_message(name )
  end

  # ------------

  def project_add(name)
    model.project_add(name)
  end

  def project_delete(name)
    model.project_delete(name)
  end

  def project_present?(name)
    model.project_present?(name)
  end

  def project_rename(old_name, new_name)
    model.project_rename(old_name, new_name)
  end

  def add_task(name)
    model.add_task(name)
  end

  def task_present?(name)
    model.task_present?(name)
  end

  def task_rename(old_name, new_name)
    model.task_rename(old_name, new_name)
  end

  def complete_task(name)
    model.complete_task(name)
  end

  # router
  def run
    run_project_menu
  end

  def run_project_menu
    print_project_menu

    welcome_menu = true

    while welcome_menu
      input = get_input

      if input == 'list'
        print_projects_list(model.projects)
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
        print_tasks_list(model.tasks)
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
