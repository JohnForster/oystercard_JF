require 'journey_log'

describe JourneyLog do
  let(:journey_log) { JourneyLog.new(Journey) }
  let(:entry_station) {double(:entry_station)}

  it 'should record the entry station' do
    expect(Journey).to receive(:new).with(entry_station)
    journey_log.begin_journey(entry_station)
  end





end
