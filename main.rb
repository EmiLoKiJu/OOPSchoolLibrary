require_relative 'student.rb'
require_relative 'teacher.rb'

student = Student.new('John', 16, 'Math101')
puts student.play_hooky

teacher = Teacher.new('John', 16, 'science')
puts teacher.can_use_services?

student2 = Student.new('Jane', 17, 'Science', parent_permission: false)