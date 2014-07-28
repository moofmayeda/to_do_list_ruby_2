class List
  def initialize(description)
    @tasks = []
    @description = description
  end
  def describe
    @description
  end
  def add_task(task)
    @tasks << task
  end

  def tasks
    @tasks
  end

  def complete_task(task)
    @completed_tasks = Array.new(0)
    @completed_tasks << @tasks.delete(task)
  end

  def delete_task(task)
    @tasks.delete(task)
  end

  def completed_tasks
    @completed_tasks
  end

  def by_date
    @tasks.sort {|a, b| a.due_date <=> b.due_date}
  end

  def by_priority
    @tasks.sort {|a, b| b.priority <=> a.priority}
  end

  def by_description
    @tasks.sort {|a, b| a.describe <=> b.describe}
  end
end
