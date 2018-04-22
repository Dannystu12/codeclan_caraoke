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

  def check_playlist playlist
    return unless @favourite_song
    result = "No way! \"#{@favourite_song.title}\", is my Jam!!!"
    result if playlist.include? @favourite_song
  end

  def == obj
    obj.class == Guest && obj.name == @name && obj.money == @money && obj.favourite_song == @favourite_song
  end

end
