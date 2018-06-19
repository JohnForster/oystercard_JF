require 'journey'

class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = Journey::MINIMUM_FARE

  def initialize
    @balance = 0
    @in_journey = false
  end

  attr_reader :balance

  def in_journey?
    !!@current_journey
  end

  def top_up(amount)
    raise "Balance cannot exceed £#{MAX_BALANCE}." if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Balance must be above £#{MIN_BALANCE}." if balance < MIN_BALANCE
    begin_journey(entry_station)
  end

  def touch_out
    deduct(Journey::MINIMUM_FARE)
    @current_journey = nil
  end

  def entry_station
    @current_journey.entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def begin_journey(entry_station)
    @in_journey = true
    @current_journey = Journey.new(entry_station)
  end
end
