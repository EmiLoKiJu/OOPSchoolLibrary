require_relative 'person'
require_relative 'student'
require_relative 'classroom'
require_relative 'book'
require_relative 'rental'

book1 = Book.new('For my Arianators <3', 'Ariana grande')
book2 = Book.new('The king of pop', 'Michael Jackson')

person1 = Person.new('John Doe', 25)
person2 = Person.new('Jane Smith', 30)

classroom1 = Classroom.new('Class A')

student1 = Student.new('Ariana', 20, classroom1)
student2 = Student.new('Michael', 22, classroom1)

rental1 = Rental.new('2023-07-27', book1, student1)
rental2 = Rental.new('2022-06-18', book2, student2)
rental3 = Rental.new('2021-05-09', book2, student1)
rental4 = Rental.new('2020-04-13', book1, student2)

puts "The classroom1 has this students:"
classroom1.students.each { |student| puts student.name }

puts "The student \"#{rental1.person.name}\" rented \"#{rental1.book.title}\" on #{rental1.date}"
puts "The student \"#{rental2.person.name}\" rented \"#{rental2.book.title}\" on #{rental1.date}"
puts "The student \"#{rental3.person.name}\" rented \"#{rental3.book.title}\" on #{rental1.date}"
puts "The student \"#{rental4.person.name}\" rented \"#{rental4.book.title}\" on #{rental1.date}"

