class Controller
  extend Forwardable
  attr_reader :view, :model
  def initialize(model, view)
    @view = view
    @model = model
  end

  def_delegator :view, :get_input


  def list_project_action
    view.print_projects_list(model.projects)
  end
  def create_project_action
    view.print_project_create_prompt
    model.project_add(get_input)
    view.print_project_menu
  end
  def delete_project_action
    view.print_project_delete_prompt
    model.project_delete(get_input)
  end
  def rename_project_action
    view.print_project_rename_prompt
    if model.project_present?(old_name = get_input)
      view.print_prompt_for_new_project_name
      model.project_rename(old_name, get_input)
    end
  end
  # def edit_project_action
  #   view.print_project_edit_prompt
  #   project_name = get_input
  #   if model.project_present?(project_name)
  #     run_task_menu(project_name)                               #????
  #     view.print_task_menu(project_name)
  #   end
  # end


  def list_task_action
    view.print_tasks_list(model.tasks)
  end

  def create_task_action
    view.print_new_task_prompt
    model.add_task(get_input)
  end
  def edit_task_action
    view.print_task_edit_prompt
    old_name = get_input
    if model.task_present?(old_name)
      view.print_prompt_for_new_task_name
      model.task_rename(old_name, get_input)
    else
      view.print_task_not_here_message(old_name)
    end
  end
  def complete_task_action
    complete_task = get_input
    if model.task_present?(complete_task)
      model.complete_task(complete_task)
    else
      view.print_task_not_here_message(complete_task)
    end
  end
end
