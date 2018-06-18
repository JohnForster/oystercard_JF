class Oystercard
  MAX_BALANCE = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  attr_reader :balance, :in_journey

  def in_journey?
    in_journey
  end

  def top_up(amount)
    raise "Balance cannot exceed £#{MAX_BALANCE}." if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
