require 'journey'

describe Journey do
  it { is_expected.to respond_to(:entry_station) }
  let(:journey) { Journey.new('Shoreditch') }

  describe '#initialize' do
    it 'should set the entry station' do
      expect(journey.entry_station).to eq 'Shoreditch'
    end
  end

  describe '#fare' do
    it 'calculates the fare' do
      journey.instance_variable_set(:@exit_station, 'Aldgate')
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    it 'returns penalty fare if no entry station is specified' do
      journey2 = Journey.new
      expect(journey2.fare).to eq Journey::PENALTY_FARE
    end
  end

  describe '#complete' do
    it 'assigns the exit station' do
      journey.complete('Aldgate')
      expect(journey.exit_station).to eq 'Aldgate'
    end

    it 'completes the journey' do
      journey.complete('Aldgate')
      expect(journey.in_progress?).to eq false
    end
  end
end
