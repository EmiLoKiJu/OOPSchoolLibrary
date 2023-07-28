require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(name = 'Unknown', age = nil, classroom = nil, parent_permission: true)
    super(name, age, parent_permission: parent_permission)
    @classroom = classroom
    classroom&.add_student(self)
    @rentals = []
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def add_rental(rental)
    @rentals << rental
  end
end
