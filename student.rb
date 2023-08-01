require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(name = 'Unknown', age = nil, classroom = nil, parent_permission: true)
    super(name, age, parent_permission: parent_permission)
    @classroom = classroom
    classroom&.add_student(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def to_json(_options = {})
    {
      type: 'Student',
      name: @name,
      age: @age,
      classroom: @classroom,
      parent_permission: @parent_permission
    }.to_json
  end
end
