require 'station'

describe Station do
  let(:station) { Station.new('Aldgate East', 1) }
  describe '#zone' do
    it 'should return the zone that the station is in.' do
      expect(station.zone).to eq 1
    end
  end

  describe '#name' do
    it 'should return the name of the station' do
      expect(station.name).to eq 'Aldgate East'
    end
  end
end
