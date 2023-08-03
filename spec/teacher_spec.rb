require_relative '../teacher'
require 'json'

describe Teacher do
  before(:each) do
    @teacher_class = Teacher.new('Jean', 40, 'Math')
  end
  context 'For teacher we can test all attribute and json method and also can I use your service method' do
    it 'Ensure the value of attribute' do
      expect(@teacher_class.name).to eq('Pierre')
      expect(@teacher_class.age).to eq 40
      expect(@teacher_class.specialization).to eq('Math')
      expect(@teacher_class.parent_permission).to be true
    end

    it 'Json method' do
      expected_json = {
        type: 'Teacher',
        name: 'Pierre',
        age: 40,
        specialization: 'Math',
        parent_permission: true
      }.to_json
      expect(@teacher_class.to_json).to eq(expected_json)
    end

    it 'can i use your service method' do
      expect(@teacher_class.can_use_services?).to be true
    end
  end
end
