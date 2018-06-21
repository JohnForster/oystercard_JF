# frozen_string_literal: true

require './lib/journey'
require './lib/journey_log'

# Allows the user to conduct and store journeys.
class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = Journey::MINIMUM_FARE

  attr_reader :balance

  def initialize(balance = 0)
    @balance = balance
    @journey_log = JourneyLog.new(Journey)
  end

  def in_journey?
    !!@journey_log.current_journey
  end

  def top_up(amount)
    raise "Balance cannot exceed £#{MAX_BALANCE}." if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Balance must be above £#{MIN_BALANCE}." if balance < MIN_BALANCE
    @journey_log.begin_journey(entry_station)
  end

  def touch_out(exit_station)
    @journey_log.end_journey(exit_station)
    deduct(@journey_log.last_fare)
  end

  def list_past_journeys
    @journey_log.past_journeys
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
