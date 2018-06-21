# frozen_string_literal: true

require 'csv'

# Stores information about a station, so it can be used by the Journey class
class Station
  attr_reader :name, :zone
  STATIONS = CSV.read('./london_stations.csv').map { |row| [row[0].downcase, row[5].split(',').map(&:to_i)] }.to_h

  def initialize(name)
    @name = name.to_s
    @zone = STATIONS[@name.downcase]
  end
end
