require 'securerandom'
require_relative 'nameable'

class Person < Nameable
  attr_reader :id, :name, :age, :parent_permission, :rentals

  def initialize(name = 'Unknown', age = nil, parent_permission: true)
    super()
    @id = SecureRandom.uuid
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
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

  def correct_name
    @name
  end

  def add_rental(rental)
    @rentals << rental
  end

  private

  def of_age?
    @age >= 18
  end
end
