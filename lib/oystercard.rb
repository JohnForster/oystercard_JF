require './lib/journey'
require './lib/journey_log'

class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = Journey::MINIMUM_FARE

  attr_reader :balance, :past_journeys

  def initialize(balance = 0)
    @balance = balance
    @journey_log = JourneyLog.new(Journey)
    # @in_journey = false
    # @past_journeys = []
    # @current_journey = nil

  end

  def in_journey?
    # move into JourneyLog?
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
    #@journey_log.current_journey.complete(exit_station)
    @journey_log.end_journey(exit_station)
    deduct(@journey_log.last_fare)
    # complete the journey (add exit_station to @current_journey)
    # @past_journeys << @current_journey

    #@current_journey = nil
  end

  # unnecessary? Rename?
  # def entry_station
  #   @current_journey.entry_station
  # end

  def list_past_journeys
    @journey_log.past_journeys
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  # def begin_journey(entry_station)
  #   @in_journey = true
  #   @current_journey = Journey.new(entry_station)
  # end
end
