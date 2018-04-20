class Room
  attr_reader :name
  def initialize name, guests=[], playlist=[]
    @name, @guests, @playlist = name, guests, playlist
  end

  def count_guests
    @guests.count
  end

  def playlist_size
    @playlist.size
  end

  def check_in_guest guest
    @guests << guest
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
