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
    return unless guest.can_afford? @fee
    @guests << guest if count_guests < @capacity
    guest.pay_money @fee
    playlist_check = guest.check_playlist @playlist
    p playlist_check if playlist_check
  end

  def contains_guest? guest
    @guests.include? guest
  end

  def check_out_guest guest
    @guests.delete guest
  end

end
