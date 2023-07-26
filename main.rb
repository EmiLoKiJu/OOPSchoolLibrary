require_relative 'student'
require_relative 'teacher'

student = Student.new('John', 16, 'Math101')
puts student.play_hooky

teacher = Teacher.new('John', 16, 'science')
puts teacher.can_use_services?
