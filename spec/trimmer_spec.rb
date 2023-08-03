require_relative '../trimmer_decorator'


RSpec.describe TrimmerDecorator do
  let(:nameable_object) { double('Nameable', correct_name: 'VeryLongName') }
  let(:decorator) { TrimmerDecorator.new(nameable_object) }

  describe '#correct_name' do
    it 'trims the name to 10 characters' do
      expect(decorator.correct_name).to eq('VeryLongNa')
    end

    it 'calls correct_name on the nameable object' do
      expect(nameable_object).to receive(:correct_name)
      decorator.correct_name
    end
  end
end
