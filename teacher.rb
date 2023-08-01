require_relative 'person'

class Teacher < Person
  def initialize(name = 'Unknown', age = nil, specialization = nil, parent_permission: true)
    super(name, age, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_json(options = {})
    {
      type: 'Teacher',
      name: @name,
      age: @age,
      specialization: @specialization,
      parent_permission: @parent_permission
    }.to_json
  end
end
