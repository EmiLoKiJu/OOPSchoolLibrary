require 'rspec'
require_relative '../capitalize_decorator'

RSpec.describe CapitalizeDecorator do
  let(:nameable_mock) { double('Nameable') }

  context '#correct_name' do
    it 'should call correct_name on the nameable object and capitalize the result' do
      expect(nameable_mock).to receive(:correct_name).and_return('john')
      decorator = CapitalizeDecorator.new(nameable_mock)
      expect(decorator.correct_name).to eq('John')
    end
  end
end
