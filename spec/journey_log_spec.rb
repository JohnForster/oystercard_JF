require 'journey_log'

describe JourneyLog do
  let(:Journey) { double(:Journey) }
  let(:journey_log) { JourneyLog.new(double(Journey)) }
  let(:journey) { double(:journey) }
  let(:entry_station) {double(:entry_station)}
  let(:exit_station) {double(:exit_station)}

  describe '#begin_journey' do
    it 'should record the entry station' do
      expect(Journey).to receive(:new).with(entry_station)
      journey_log.begin_journey(entry_station)
    end
  end

  describe '#end_journey' do
    context 'with no current journey' do
      # it 'should create a finished journey' do
      #   expect(journey_log).to receive(:create_finished_journey).with(exit_station)
      #   allow(journey).to receive(:complete)
      #   journey_log.end_journey(exit_station)
      # end
    end

    context 'with an ongoing journey' do
      it 'should complete the current journey' do
        journey_log.instance_variable_set(:@current_journey, journey)
        expect(journey).to receive(:complete).with(exit_station)
        journey_log.end_journey(exit_station)
      end
    end

    it 'should reset the journey log' do
      allow(journey_log).to receive(:create_finished_journey)
      journey_log.instance_variable_set(:@current_journey, journey)
      allow(journey).to receive(:complete)
      expect(journey_log).to receive(:reset)
      journey_log.end_journey(exit_station)
    end
  end
end
