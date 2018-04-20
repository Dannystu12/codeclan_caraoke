class Guest
  attr_reader :name, :money
  def initialize name, money
    @name, @money = name, money
  end

  def pay_money payment
    return false if payment < 0 || payment > @money
    @money -= payment
    true
  end
end
