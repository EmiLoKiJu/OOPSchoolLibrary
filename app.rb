require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'book'
require_relative 'rental'
require 'json'

# rubocop:disable Metrics/ClassLength
class App
  attr_reader :people, :books

  def initialize
    @books = []
    @people = []
    @rentals = []
    @total_data = {
      'people' => -> { @people },
      'rentals' => -> { @rentals },
      'books' => -> { @books }
    }
  end

  def create_student(name = 'Unknown', age = nil, classroom = nil, parent_permission: true)
    student = Student.new(name, age, classroom, parent_permission: parent_permission)
    @people << student
  end

  def create_teacher(name = 'Unknown', age = nil, specialization = nil, parent_permission: true)
    teacher = Teacher.new(name, age, specialization, parent_permission: parent_permission)
    @people << teacher
  end

  def create_book(title = nil, author = nil)
    book = Book.new(title, author)
    @books << book
  end

  def create_rental(date = nil, book = nil, person = nil)
    rental = Rental.new(date, book, person)
    @rentals << rental
  end

  def rentals(person_id)
    @rentals.select { |rental| rental.person.id == person_id }
  end

  # add code

  def insert_student(age)
    print 'Name [Input the name]: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    pp = gets.chomp
    case pp
    when 'Y'
      pp = true
    when 'N'
      pp = false
    else
      puts 'Invalid choice. Please try again'
      return
    end
    create_student(name, age, nil, parent_permission: pp)
    puts "\nPerson created successfully\n"
  end

  def insert_teacher(age)
    print 'Give me the name [Input the name]: '
    name = gets.chomp
    print 'Give me the specialization [Input the specialization]: '
    spec = gets.chomp
    create_teacher(name, age, spec)
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

  def insert_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    choice2 = gets.chomp.to_i
    case choice2
    when 1
      print 'You want to create a student. Give me the age [Input the number for age]: '
      age = gets.chomp.to_i
      age_zero?(age) ? return : insert_student(age)
    when 2
      print 'You want to create a teacher. Give me the age [Input the number for age]: '
      age = gets.chomp.to_i
      age_zero?(age) ? return : insert_teacher(age)
    else
      puts 'Invalid choice. Please try again'
    end
  end

  def insert_book
    print 'You want to create a book. Give me the title [Input the title]: '
    title = gets.chomp
    print 'Give me the author [Input the author]: '
    author = gets.chomp
    create_book(title, author)
    puts "\n"
    puts 'Book created successfully'
    puts "\n"
  end

  def insert_rental
    if people.empty?
      puts "No people in the app yet. Add some people first to make a rental\n"
      return
    elsif books.empty?
      puts "No books in the app yet. Add some books first to make a rental\n"
      return
    end
    puts 'Select a book from the following list by number'
    show_books_with_index
    book_index = gets.chomp.to_i
    puts 'Select a person from the following list by number (not id)'
    show_people_with_index
    people_index = gets.chomp.to_i
    print 'Give me the date [Input the date in format YYYY/MM/DD]: '
    date = gets.chomp
    create_rental(date, books[book_index], people[people_index])
    puts "\nRental created successfully\n"
  end

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

  def show_rentals_by_id
    print 'ID of person: '
    person_id = gets.chomp
    rentals = rentals(person_id)
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

  def show_books
    if books.empty?
      puts 'No books in the app yet'
    else
      puts 'List of Books:'
      books.each do |book|
        puts "Title: \"#{book.title}\", Author: #{book.author}"
      end
    end
    puts "\n"
  end

  def show_people
    if people.empty?
      puts 'No people in the app yet'
    else
      puts 'List of People:'
      people&.each do |person|
        if person.is_a?(Student)
          puts "[Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
        else
          puts "[Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
        end
      end
    end
    puts "\n"
  end

  def show_books_with_index
    books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def show_people_with_index
    people.each_with_index do |person, index|
      if person.is_a?(Student)
        puts "#{index}. [Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      elsif person.is_a?(Teacher)
        puts "#{index}. [Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      else
        puts "#{index}. #{person.name} (#{person.age} years old)"
      end
    end
  end

  def check_data
    @total_data.each do |data_string, data_adress|
      if File.exist?("stored_data/#{data_string}.json")
        puts 'file exists'
        json_data = File.read("stored_data/#{data_string}.json")
        data = JSON.parse(json_data)
        if data_string == 'people'
          data.each do |person_data|
            if person_data['type'] == 'Student'
              create_student(
                person_data['name'],
                person_data['age'],
                person_data['classroom'],
                parent_permission: person_data['parent_permission']
              )
            elsif person_data['type'] == 'Teacher'
              create_teacher(
                person_data['name'],
                person_data['age'],
                person_data['specialization']
              )
            end
          end
        elsif data_string == 'books'
          data.each do |book_data|
            create_book(
              book_data['title'],
              book_data['author'],
            )
          end
        elsif data_string == 'rentals'
          data.each do |rental_data|
            create_rental(
              rental_data['date'],
              rental_data['book'],
              rental_data['person']
            )
          end
        end
        puts "Data loaded from 'stored_data/#{data_string}.json'"
      else
        puts "Data file not found: 'stored_data/#{data_string}.json'"
      end
    end
  end

  def save_changes
    @total_data.each do |data_string, data_adress|
      datajson = JSON.generate(data_adress.call)
      File.open("stored_data/#{data_string}.json", 'w') do |file|
        file.write(datajson)
        puts "write to stored_data/#{data_string}.json the data = #{data_adress.call}"
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength
