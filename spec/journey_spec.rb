require 'journey'

describe Journey do
  it { is_expected.to respond_to(:entry_station) }

  describe '#initialize' do
    it 'should set the entry station' do
      journey = Journey.new(:shoreditch)
      expect(journey.entry_station).to eq :shoreditch
    end
  end
end
