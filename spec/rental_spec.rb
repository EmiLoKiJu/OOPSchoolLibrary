require 'rspec'
require_relative '../rental.rb'
require_relative '../book.rb'
require_relative '../person.rb'

RSpec.describe Rental do
  let(:book) { Book.new('Book Title', 'Book Author') }
  let(:person) { Person.new('John Doe', 30) }
  let(:rental) { Rental.new }

  describe '#initialize' do
    it 'should initialize with default values when not provided' do
      expect(rental.date).to be_nil
      expect(rental.book).to be_nil
      expect(rental.person).to be_nil
    end

    it 'should initialize with provided values' do
      date = '2023-08-02'
      rental1 = Rental.new(date, book, person)
      expect(rental1.date).to eq(date)
      expect(rental1.book).to eq(book.title)
      expect(rental1.person).to eq(person.id)
    end
  end

  describe '#to_json' do
    it 'should return JSON representation of the rental object' do
      rental = Rental.new('2023-08-02', book, person)
      expected_json = {
        date: '2023-08-02',
        book: book.title,
        person: person.id
      }.to_json
      expect(rental.to_json).to eq(expected_json)
    end
  end
end