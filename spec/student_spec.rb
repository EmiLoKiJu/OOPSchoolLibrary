require_relative '../student.rb'
require_relative '../classroom.rb'
require 'rspec'
require 'json'

RSpec.describe Student do  
    describe '#initialize' do
      it 'should initialize with default values when not provided' do
        student = Student.new
        expect(student.name).to eq('Unknown')
        expect(student.age).to be_nil
        expect(student.classroom).to be_nil
        expect(student.parent_permission).to be_truthy
      end
  
      it 'should initialize with provided values' do
        classroom = Classroom.new('Math')
        student2 = Student.new('Alice', 16, classroom, parent_permission: true)
        expect(student2.name).to eq('Alice')
        expect(student2.age).to eq(16)
        expect(student2.classroom).to eq(classroom.label)
        expect(student2.parent_permission).to be_truthy
      end
    end
  
    describe '#play_hooky' do
      it 'should return the hooky message' do
        student = Student.new
        expect(student.play_hooky).to eq('¯\\(ツ)/¯')
      end
    end
  
    describe '#to_json' do
      it 'should return JSON representation of the student object' do
        classroom2 = Classroom.new('Math')
        student4 = Student.new('Alice', 16, classroom2, parent_permission: true)
        expected_json = {
          type: 'Student',
          name: 'Alice',
          age: 16,
          classroom: classroom2.label,
          parent_permission: true
        }.to_json
        expect(student4.to_json).to eq(expected_json)
      end
    end
  end

