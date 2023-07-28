require_relative 'person'
require_relative 'student'
require_relative 'classroom'
require_relative 'book'
require_relative 'rental'
require_relative 'app'

@app = App.new

# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
def main(app = nil)
  loop do
    menu
    choice = gets.chomp.to_i
    case choice
    when 1
      show_books(app)
    when 2
      show_people(app)
    when 3
      insert_person(app)
    when 4
      insert_book(app)
    when 5
      insert_rental(app)
    when 6
      show_rentals_by_id(app)
    when 7
      break
    else
      puts 'Invalid choice. Please try again'
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength

def menu
  puts 'Please choose an option by entering a number:'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - Exit'
  print "\nEnter your choice: "
end

def insert_student(app, age)
  print 'Name [Input the name]: '
  name = gets.chomp
  print 'Has parent permission? [Y/N]: '
  parent_permission = gets.chomp
  case parent_permission
  when 'Y'
    app.create_student(name, age, nil, parent_permission: true)
  when 'N'
    app.create_student(name, age, nil, parent_permission: false)
  else
    puts 'Invalid choice. Please try again'
  end
  puts "\nPerson created successfully\n"
end

def insert_teacher(app, age)
  print 'Give me the name [Input the name]: '
  name = gets.chomp
  print 'Give me the specialization [Input the specialization]: '
  spec = gets.chomp
  app.create_teacher(name, age, spec)
  puts "\n"
  puts 'Person created successfully'
  puts "\n"
end

def age_zero?(age)
  if age.zero?
    puts "invalid age. Please try again\n"
    true
  else
    false
  end
end

def insert_person(app)
  print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
  choice2 = gets.chomp.to_i
  case choice2
  when 1
    print 'You want to create a student. Give me the age [Input the number for age]: '
    age = gets.chomp.to_i
    age_zero?(age) ? return : insert_student(app, age)
  when 2
    print 'You want to create a teacher. Give me the age [Input the number for age]: '
    age = gets.chomp.to_i
    age_zero?(age) ? return : insert_teacher(app, age)
  else
    puts 'Invalid choice. Please try again'
  end
end

def insert_book(app)
  print 'You want to create a book. Give me the title [Input the title]: '
  title = gets.chomp
  print 'Give me the author [Input the author]: '
  author = gets.chomp
  app.create_book(title, author)
  puts "\n"
  puts 'Book created successfully'
  puts "\n"
end

def insert_rental(app)
  if app.people.empty?
    puts "No people in the app yet. Add some people first to make a rental\n"
    return
  elsif app.books.empty?
    puts "No books in the app yet. Add some books first to make a rental\n"
    return
  end
  puts 'Select a book from the following list by number'
  show_books_with_index(app)
  book_index = gets.chomp.to_i
  puts 'Select a person from the following list by number (not id)'
  show_people_with_index(app)
  people_index = gets.chomp.to_i
  print 'Give me the date [Input the date in format YYYY/MM/DD]: '
  date = gets.chomp
  app.create_rental(date, app.books[book_index], app.people[people_index])
  puts "\nRental created successfully\n"
end

def show_rentals_by_id(app)
  print 'ID of person: '
  person_id = gets.chomp
  rentals = app.rentals(person_id)
  if rentals.empty?
    puts "No rentals found for a person with this ID: #{person_id}"
  else
    puts 'Rentals:'
    rentals.each do |rental|
      puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end
  puts "\n"
end

def show_books(app)
  if app.books.empty?
    puts 'No books in the app yet'
  else
    puts 'List of Books:'
    app&.books&.each do |book|
      puts "Title: \"#{book.title}\", Author: #{book.author}"
    end
  end
  puts "\n"
end

# rubocop:disable Metrics/CyclomaticComplexity
def show_people(app)
  if app.people.empty?
    puts 'No people in the app yet'
  else
    puts 'List of People:'
    app&.people&.each do |person|
      if person.is_a?(Student)
        puts "[Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      elsif person.is_a?(Teacher)
        puts "[Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      else
        puts "#{person.name} (#{person.age} years old)"
      end
    end
  end
  puts "\n"
end
# rubocop:enable Metrics/CyclomaticComplexity

def show_books_with_index(app)
  app.books.each_with_index do |book, index|
    puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
  end
end

def show_people_with_index(app)
  app.people.each_with_index do |person, index|
    if person.is_a?(Student)
      puts "#{index}. [Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    elsif person.is_a?(Teacher)
      puts "#{index}. [Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    else
      puts "#{index}. #{person.name} (#{person.age} years old)"
    end
  end
end

puts 'Welcome to School Library App!'
main(@app)
