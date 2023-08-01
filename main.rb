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
    app.menu
    choice = gets.chomp.to_i
    case choice
    when 1
      app.show_books
    when 2
      app.show_people
    when 3
      app.insert_person
    when 4
      app.insert_book
    when 5
      app.insert_rental
    when 6
      app.show_rentals_by_id
    when 7
      break
    else
      puts 'Invalid choice. Please try again'
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength

puts 'Welcome to School Library App!'
main(@app)
