class Model
  attr_reader :projects, :tasks

  def initialize
    @projects = read_file
    @tasks = []
  end

  def read_file
    File.exist?('projects.txt') ? (File.open('projects.txt', 'r').read.split("\n")) : Array.new
  end

  def write_file
    data_string = @projects.join("\n")
    File.open('projects.txt', 'w') do |f|
      f.write(data_string)
    end
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
end
