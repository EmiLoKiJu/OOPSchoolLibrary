require 'securerandom'

class Person
  def initialize(name = "Unknown", age = nil, parent_permission = true)
    @id = SecureRandom.uuid
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def id
    @id
  end

  def name
    @name
  end

  def age
    @age
  end

  def rename(name)
    @name = name
  end

  def update_age(new_age)
    @age = new_age
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def of_age?
    @age >= 18
  end
end