require_relative '../student.rb'
require 'rspec'
require 'json'

RSpec.describe Student do  
    context '#initialize' do
      it 'should initialize with default values when not provided' do
        student = Student.new
        expect(student.name).to eq('Unknown')
        expect(student.age).to be_nil
        expect(student.classroom).to be_nil
        expect(student.parent_permission).to be_truthy
      end
  
      it 'should initialize with provided values' do
        classroom_mock = instance_double(Classroom, label: 'Math')
        allow(classroom_mock).to receive(:add_student)
        student2 = Student.new('Alice', 16, classroom_mock, parent_permission: true)

        expect(student2.name).to eq('Alice')
        expect(student2.age).to eq(16)
        expect(student2.classroom).to eq(classroom_mock.label)
        expect(student2.parent_permission).to be_truthy
      end
    end
  
    context '#play_hooky' do
      it 'should return the hooky message' do
        student = Student.new
        expect(student.play_hooky).to eq('¯\\(ツ)/¯')
      end
    end
  
    context '#to_json' do
      it 'should return JSON representation of the student object' do
        classroom_mock = instance_double(Classroom, label: 'Math')
        allow(classroom_mock).to receive(:add_student)
        student4 = Student.new('Alice', 16, classroom_mock, parent_permission: true)
        expected_json = {
          type: 'Student',
          name: 'Alice',
          age: 16,
          classroom: classroom_mock.label,
          parent_permission: true
        }.to_json
        expect(student4.to_json).to eq(expected_json)
      end
    end
  end

