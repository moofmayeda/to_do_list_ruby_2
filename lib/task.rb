class Task
  def initialize(description)
    @priority = 1
    @new_date = Time.new
    @description = description
  end
  def describe
    @description
  end
  def edit_description(new_description)
    @description = new_description
  end
  def set_due(month, day, year)
    @new_date = Time.new(year, month, day)
  end
  def date_stamp
    @new_date
  end
  def due_date
    "#{@new_date.year}-#{@new_date.month}-#{@new_date.day}"
  end
  def set_level(level)
    @priority = level
  end
  def priority
    @priority
  end
end
