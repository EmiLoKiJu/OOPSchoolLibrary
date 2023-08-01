class Rental
  attr_accessor :date
  attr_reader :book, :person

  def initialize(date = nil, book = nil, person = nil)
    @date = date
    @book = book
    @person = person
    book&.add_rental(self)
    person&.add_rental(self)
  end

  def to_json(_options = {})
    {
      date: @date,
      book: @book,
      person: @person
    }.to_json
  end
end
