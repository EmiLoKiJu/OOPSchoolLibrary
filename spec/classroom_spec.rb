require 'rspec'
require_relative '../classroom.rb'
require_relative '../student.rb'

RSpec.describe Classroom do
  let(:classroom) { Classroom.new }

  describe '#initialize' do
    it 'should initialize with a default label when not provided' do
      expect(classroom.label).to be_nil
    end

    it 'should initialize with the provided label' do
      classroom_with_label = Classroom.new('Math Class')
      expect(classroom_with_label.label).to eq('Math Class')
    end

    it 'should initialize with an empty students array' do
      expect(classroom.students).to be_empty
    end
  end

  describe '#add_student' do
    it 'should add the student to the students array' do
      student = Student.new
      classroom.add_student(student)
      expect(classroom.students).to include(student.id)
    end
  end
end