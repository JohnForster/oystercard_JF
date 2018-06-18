class Oystercard
  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  attr_reader :balance

  def top_up(amount)
    raise "Balance cannot exceed £#{MAX_BALANCE}." if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
