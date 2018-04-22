class Room
  attr_reader :name, :capacity, :fee, :song_fee

  def initialize name, playlist: [], capacity: 10, fee: 5, song_fee: 1
    @name, @playlist = name, playlist
    @capacity, @fee = capacity, fee
    @song_fee = song_fee
    @tabs, @guests =[], []
  end

  def count_guests
    @guests.count
  end

  def playlist_size
    @playlist.size
  end

  def tab_count
    @tabs.count
  end

  def check_in_guest guest
    return unless guest.can_afford?(@fee) && count_guests < @capacity
    @guests << guest
    @tabs << Tab.new(guest, @fee)
    playlist_check = guest.check_playlist @playlist
    playlist_check ? playlist_check : nil
  end

  def contains_guest? guest
    @guests.include? guest
  end

  def check_out_guest guest
    return unless contains_guest? guest
    tab = get_tab guest
    raise Exception.new("could not retrieve tab for guest") if !tab
    tab.pay_balance
    @tabs.delete tab
    @guests.delete guest
  end

  def buy_song guest, song
    return unless contains_guest? guest
    tab = get_tab guest
    return unless tab.can_add? @song_fee
    tab.add @song_fee
    @playlist << song
  end

  def get_tab guest
    @tabs.find {|tab| tab.guest == guest}
  end

  def play_next_song
    return unless playlist_size > 0
    song = @playlist.shift
    "Now playing \"#{song.title}\" by #{song.artist}"
  end
end
