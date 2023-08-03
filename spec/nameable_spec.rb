require_relative '../nameable'

# I decide to define a subclass of Nameable for testing purposes
class TestNameable < Nameable
  def correct_name
    'Test Name'
  end
end

RSpec.describe TestNameable do
  let(:nameable) { TestNameable.new }

  describe '#correct_name' do
    it 'returns the correct name' do
      expect(nameable.correct_name).to eq('Test Name')
    end
  end
end
