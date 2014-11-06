require 'spec_helper'

describe Todos, "#run" do
  # Don't mind all this crazy setup, testing command line apps is hard!
  let(:io_input)  { StringIO.new("") }
  let(:io_output) { StringIO.new("") }

  let(:app) { Todos.new(io_input, io_output) }
  let(:output) { io_output.string }

  describe "Introductory text" do
    before do
      stub_user_input("quit")
      app.run
    end

    it "includes 'Welcome'" do
      expect(output).to include("Welcome")
    end

    xit "include instructions for listing projects" do
      expect(output).to include("'list' to list projects")
    end

    xit "include instructions for listing projects" do
      expect(output).to include("'create' to create a new project")
    end

    xit "include instructions for listing projects" do
      expect(output).to include("'edit' to edit a project")
    end
  end

  describe "quitting and looping" do
    describe "when the input is quit" do
      before do
        expect_user_input('quit')
      end

      xit "the program exits" do
        app.run
      end
    end

    describe "when the input is something else" do
      before do
        expect_user_input('gerbil', 'fish', 'quit')
      end

      xit "asks for more input" do
        app.run
      end
    end
  end

  describe 'working with projects' do
    describe "listing" do
      describe 'when there are no projects' do
        before do
          stub_user_input("list", "quit")
          app.run
        end

        xit "shows an empty list" do
          expect(output).to include("Projects:\n  none")
        end
      end
    end

    describe 'creating' do
      before do
        stub_user_input("create", "Chores", "list", "quit")
        app.run
      end

      xit "new projects will show up in the list" do
        expect(output).to include("Projects:\n  Chores")
      end
    end
  end

  describe 'creating tasks within a project' do
    let(:project_setup_commands) { ['create', "Chores", "edit", "Chores"] }
    let(:task_creation_commands) { ['create', 'do the laundry', 'create', 'iron shirts'] }

    describe 'new menu when editing a project' do
      before do
        stub_user_input(project_setup_commands, 'quit')
        app.run
      end

      xit "includes the project name" do
        expect(output).to include("Editing Project: Chores")
      end

      xit "gives instruction for listing tasks" do
        expect(output).to include("'list' to list tasks")
      end

      xit "gives instructions for other tasks" do
        expect(output).to include("'create' to create a new task")
        expect(output).to include("'edit' to edit a task")
        expect(output).to include("'complete' to complete a task and remove it from the list")
      end
    end

    describe 'listing' do
      describe 'when there are no tasks' do
        before do
          stub_user_input(project_setup_commands,'list', 'quit')
        end

        xit "does not show projects" do
          app.run
          expect(output).to_not include("Projects:\n  Chores")
        end

        xit "shows 'none'" do
          app.run
          expect(output).to include("  none")
        end
      end

      describe 'when tasks have been created' do
        before do
          stub_user_input(project_setup_commands, task_creation_commands, 'list', 'quit')
        end

        xit "should not show projects" do
          app.run
          expect(output).to_not include("Projects:\n  Chores")
        end

        xit "should show new tasks" do
          app.run
          expect(output).to include("do the laundry")
          expect(output).to include("iron shirts")
        end
      end
    end

    describe 'editing a task' do
      describe 'when the task is found' do
        before do
          stub_user_input(project_setup_commands, task_creation_commands, 'edit', 'iron shirts', 'iron clothes', 'list', 'quit')
        end

        xit "should update the task in the list" do
          app.run
          expect(output).to include("iron clothes")
          expect(output).not_to include("iron shirts")
        end
      end

      describe 'when the task is not found' do
        before do
          stub_user_input(project_setup_commands, task_creation_commands, 'edit', 'not here', 'quit')
        end

        xit "should report and return to normal menu" do
          app.run
          expect(output).to include("task not found: 'not here'")
        end
      end
    end

    describe 'completing a task' do
      describe 'when task is found' do
        before do
          stub_user_input(project_setup_commands, task_creation_commands, 'complete', 'do the laundry', 'list', 'quit')
        end

        xit "should no longer list the task" do
          app.run
          expect(output).not_to include("do the laundry")
        end
      end

      describe 'when task is not found' do
        before do
          stub_user_input(project_setup_commands, task_creation_commands, 'complete', 'not here', 'list', 'quit')
        end

        xit "should still have all its tasks" do
          app.run
          expect(output).to include('do the laundry')
          expect(output).to include('iron shirts')
        end

        xit "should report that it couldn't find the task" do
          app.run
          expect(output).to include("task not found: 'not here'")
        end
      end
    end

    describe 'going back' do
      before do
        stub_user_input(project_setup_commands, 'back', 'quit')
      end

      xit "reprints the projects instructions" do
        app.run
        expect(output.scan(/'list' to list projects/).count).to be == 2
      end
    end
  end
end
