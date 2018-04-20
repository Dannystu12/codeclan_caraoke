class Room
  attr_reader :name, :capacity, :fee
  def initialize name, guests: [], playlist: [], capacity: 10, fee: 5
    @name = name
    @guests, @playlist = guests, playlist
    @capacity, @fee = capacity, fee
  end

  def count_guests
    @guests.count
  end

  def playlist_size
    @playlist.size
  end

  def check_in_guest guest
    #pay money returns true if payment successful
    @guests << guest if count_guests < @capacity && guest.pay_money(@fee)
  end

  def contains_guest? guest_or_name
    return @guests.include? guest_or_name if guest? guest_or_name
    return @guests.any?{|guest| guest.name == guest_or_name} if string? guest_or_name
  end

  def check_out_guest guest_or_name
    return @guests.delete guest_or_name if guest? guest_or_name
    return @guests.delete_if{|guest| guest.name == guest_or_name} if string? guest_or_name
  end

  private
  def guest? obj
    obj.class == Guest
  end

  def string? obj
    obj.class == String
  end
end
