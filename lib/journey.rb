# Creates and stores information about journey
class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @in_progress = true
  end

  attr_reader :entry_station, :exit_station

  def fare
    @entry_station && @exit_station ? MINIMUM_FARE : PENALTY_FARE
  end

  def complete(exit_station)
    @exit_station = exit_station
    @in_progress = false
  end

  def in_progress?
    @in_progress
  end
end
