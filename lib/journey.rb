# Creates and stores information about journey
class Journey
  MINIMUM_FARE = 1

  def initialize(entry_station = nil)
    @entry_station = entry_station
  end

  attr_reader :entry_station
end
