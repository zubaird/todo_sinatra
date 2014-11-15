class Controller
  extend Forwardable
  attr_reader :view, :model
  def initialize(model, view)
    @view = view
    @model = model

  end

  def_delegators :view,
    :get_input,
    :print_projects_list,
    :print_project_create_prompt,
    :print_project_menu,
    :print_project_delete_prompt,
    :print_project_rename_prompt,
    :print_prompt_for_new_project_name,
    :print_tasks_list,
    :print_new_task_prompt,
    :print_task_edit_prompt,
    :print_prompt_for_new_task_name,
    :print_task_not_here_message

  def_delegators :model,
    :projects,
    :project_add,
    :project_delete,
    :project_present,
    :project_present?,
    :project_rename,
    :add_task,
    :task_present?,
    :task_rename,
    :complete_task

  def list_project_action
    print_projects_list(projects)
  end
  def create_project_action
    print_project_create_prompt
    project_add(get_input)
    print_project_menu
  end
  def delete_project_action
    print_project_delete_prompt
    project_delete(get_input)
  end
  def rename_project_action
    print_project_rename_prompt
    if project_present?(old_name = get_input)
      print_prompt_for_new_project_name
      project_rename(old_name, get_input)
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
    print_tasks_list(model.tasks)
  end

  def create_task_action
    print_new_task_prompt
    add_task(get_input)
  end
  def edit_task_action
    print_task_edit_prompt
    old_name = get_input
    if task_present?(old_name)
      print_prompt_for_new_task_name
      task_rename(old_name, get_input)
    else
      print_task_not_here_message(old_name)
    end
  end
  def complete_task_action
    complete_task = get_input
    if task_present?(complete_task)
      complete_task(complete_task)
    else
      print_task_not_here_message(complete_task)
    end
  end
end
