require_relative 'student'
require_relative 'teacher'

student = Student.new("John", 16, true, "Math101")
puts student.play_hooky

teacher = Teacher.new("John", 16, true, "science")
puts teacher.can_use_services?