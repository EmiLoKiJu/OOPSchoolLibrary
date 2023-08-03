require 'rspec'
require_relative '../base_decorator'

RSpec.describe BaseDecorator do
  let(:nameable_mock) { double('Nameable') }

  context '#initialize' do
    it 'should initialize with a nameable object' do
      decorator = BaseDecorator.new(nameable_mock)
      expect(decorator.instance_variable_get(:@nameable)).to eq(nameable_mock)
    end
  end

  context '#correct_name' do
    it 'should call correct_name on the nameable object' do
      expect(nameable_mock).to receive(:correct_name)
      decorator = BaseDecorator.new(nameable_mock)
      decorator.correct_name
    end
  end
end
