# frozen_string_literal: true

require './lib/station'
# Creates and stores information about journey
class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    entry_station ? @entry_station = Station.new(entry_station) : @entry_station = nil
    @in_progress = true
  end

  attr_reader :entry_station, :exit_station

  def fare
    @entry_station && @exit_station ? calculate_fare : PENALTY_FARE
  end

  def complete(exit_station)
    exit_station = Station.new(exit_station)
    @exit_station = exit_station
    @in_progress = false
  end

  # ?? Send back to Oystercard instance #in_journey? ??
  def in_progress?
    @in_progress
  end

  #private

  def calculate_fare
    1 + zone_difference(@entry_station.zone, @exit_station.zone)
  end

  def zone_difference(zone_array1, zone_array2)
    [(zone_array1.max - zone_array2.min).abs,(zone_array1.min - zone_array2.max).abs].min
  end

  def diff(a, b)
    (a - b).abs
  end
end
