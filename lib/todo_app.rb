class TodoApp < CommandLineApp
  attr_reader :view, :model

  def initialize(input, output)
    @input = input
    @view = View.new(output)
    @model = Model.new
  end

  def get_input
    gets.chomp
  end

  # router
  def run
    run_project_menu
  end

  def run_project_menu
    view.print_project_menu

    welcome_menu = true

    while welcome_menu
      input = get_input

      if input == 'list'
        view.print_projects_list(model.projects)
      elsif input == 'create'
        view.print_project_create_prompt
        model.project_add(get_input)
        view.print_project_menu
      elsif input == 'delete'
        view.print_project_delete_prompt
        model.project_delete(get_input)
      elsif input == 'rename'
        view.print_project_rename_prompt
        if model.project_present?(old_name = get_input)
          view.print_prompt_for_new_project_name
          model.project_rename(old_name, get_input)
        end
      elsif input == 'edit'
        view.print_project_edit_prompt
        project_name = get_input
        if model.project_present?(project_name)
          run_task_menu(project_name)
          view.print_task_menu(project_name)
        end
      elsif input == 'quit'
        welcome_menu = false
      end
    end
  end

  def run_task_menu(project_name)
    view.print_task_menu(project_name)

    task_menu = true

    while task_menu
      task_input = get_input
      if task_input == 'list'
        view.print_tasks_list(model.tasks)
      elsif task_input == 'create'
        view.print_new_task_prompt
        model.add_task(get_input)
      elsif task_input == 'edit'
        view.print_task_edit_prompt
        old_name = get_input
        if model.task_present?(old_name)
          view.print_prompt_for_new_task_name
          model.task_rename(old_name, get_input)
        else
          view.print_task_not_here_message(old_name)
        end
      elsif task_input == 'complete'
        complete_task = get_input
        if model.task_present?(complete_task)
          model.complete_task(complete_task)
        else
          view.print_task_not_here_message(complete_task)
        end
      elsif task_input == 'back'
        view.print_project_menu
        task_menu = false
      end
    end
  end

  def real_puts message = ""
    $stdout.puts message
  end
end
