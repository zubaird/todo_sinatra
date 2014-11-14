class TodoApp < CommandLineApp
  attr_reader :view, :model, :controller

  extend Forwardable
  def initialize(input, output)
    @input = input
    @view = View.new(output, input)
    @model = Model.new
    @controller = Controller.new(model, view)
  end

  # router
  def run
    run_project_menu
  end

  def_delegators :view,
    :print_project_menu,
    :print_task_menu,
    :get_input

  def_delegators :controller,
    :list_project_action,
    :create_project_action,
    :delete_project_action,
    :rename_project_action,
    # :edit_project_action,
    :list_task_action,
    :create_task_action,
    :edit_task_action,
    :complete_task_action

  def edit_project_action
    view.print_project_edit_prompt
    project_name = get_input
    if model.project_present?(project_name)
      run_task_menu(project_name)
      view.print_task_menu(project_name)
    end
  end



  def run_project_menu
    print_project_menu

    welcome_menu = true
    while welcome_menu
      input = get_input

      welcome_menu = false if input == 'quit'

      if input == 'list' # 'if' is router
        list_project_action # the 'action' is the conroller
      elsif input == 'create'
        create_project_action
      elsif input == 'delete'
        delete_project_action
      elsif input == 'rename'
        rename_project_action
      elsif input == 'edit'
        edit_project_action
      end
    end
  end

  def run_task_menu(project_name)
    print_task_menu(project_name)

    task_menu = true
    while task_menu
      task_input = get_input
      if task_input == 'list'
        list_task_action
      elsif task_input == 'create'
        create_task_action
      elsif task_input == 'edit'
        edit_task_action
      elsif task_input == 'complete'
        complete_task_action
      elsif task_input == 'back'
        print_project_menu
        task_menu = false
      end
    end
  end
end
