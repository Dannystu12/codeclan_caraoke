class Tab
  attr_reader :guest, :balance, :paid
  def initialize guest, balance
    error_str = "balance must be greater than 0"
    raise ArgumentError.new(error_str) if balance <= 0

    error_str = "guest cannot afford initial tab"
    raise ArgumentError.new(error_str) if !guest.can_afford?(balance)

    @guest, @balance, @paid = guest, balance, false
  end

  def can_add? payment
    guest.can_afford?(balance + payment)
  end

  def add payment
    return if payment <= 0
    @paid == false
    @balance += payment if can_add? payment
  end

  def pay_balance
    error_str = "guest cannot afford tab"
    raise ArgumentError.new(error_str) if !guest.can_afford?(balance)
    guest.pay_money @balance
    @balance = 0
    @paid = true
  end

end
