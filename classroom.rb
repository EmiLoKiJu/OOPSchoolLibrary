class Classroom
  attr_accessor :label

  attr_reader :students

  def initialize(label = nil)
    @label = label
    @students = []
  end

  def add_student(student)
    @students << student.id
    student.classroom = @label
  end
end
