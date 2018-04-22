class Guest
  attr_reader :name, :money, :favourite_song
  def initialize name, money, favourite_song=nil
    @name, @money, @favourite_song = name, money, favourite_song
  end

  def pay_money payment
    @money -= payment if can_afford?(payment)
  end

  def can_afford? payment
    payment >= 0 && payment <= @money
  end
end
