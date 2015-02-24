class Employee
  attr_accessor :name, :title, :salary
  attr_reader :boss

  def initialize(options)
    @name = options[:name]
    @title = options[:title]
    @salary = options[:salary]
    @boss = options[:boss]
  end

  def boss=(new_boss)
    old_boss = boss
    if old_boss
      old_boss.staff.remove(self)
    end
    @boss = new_boss
    if new_boss
      new_boss.staff << self
    end
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_accessor :staff

  def initialize(options)
    @staff = options[:staff] || []
    super(options)
  end

  def staff_total_salary
    total = 0
    staff.each do |employee|
      if employee.is_a?(Manager)
        total += employee.staff_total_salary + employee.salary
      else
        total += employee.salary
      end
    end

    total
  end

  def bonus(multiplier)
    staff_total_salary * multiplier
  end
end
