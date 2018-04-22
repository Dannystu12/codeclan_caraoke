require 'minitest/autorun'
require 'minitest/rg'
require_relative '../guest.rb'
require_relative '../song.rb'
require_relative '../room.rb'
require_relative '../tab.rb'

class RoomTest < MiniTest::Test
  def setup
    song_1 = Song.new "Forty Six & 2", "Tool"
    song_2 = Song.new "Tornado of Souls", "Megadeth"
    @playlist = [song_1, song_2]

    @song_1 = Song.new("Cry Of The Banshee", "Brocas Helm")

    @guest_1 = Guest.new "Gordon", 20, song_1
    @guest_2 = Guest.new "Andrew", 10

    @room_1 = Room.new "Metal Room", playlist:@playlist, \
    capacity:3, fee: 10, song_fee: 2
    guest_1 = Guest.new "Daniel", 10
    guest_2 = Guest.new "Connor", 10
    @room_1.check_in_guest guest_1
    @room_1.check_in_guest guest_2

    @room_2 = Room.new "Rap Room"
  end

  def test_get_name
    assert_equal "Metal Room", @room_1.name
  end

  def test_get_capacity
    assert_equal 3, @room_1.capacity
    assert_equal 10, @room_2.capacity
  end

  def test_get_fee
    assert_equal 10, @room_1.fee
    assert_equal 5, @room_2.fee
  end

  def test_guest_count
    assert_equal 2, @room_1.count_guests
    assert_equal 0, @room_2.count_guests
  end

  def test_playlist_size
    assert_equal 2, @room_1.playlist_size
    assert_equal 0, @room_2.playlist_size
  end

  def test_contains_guest__true
    @room_1.check_in_guest @guest_1
    assert_equal true, @room_1.contains_guest?(@guest_1)
  end

  def test_contains_guest__false
    assert_equal false, @room_1.contains_guest?(@guest_1)
  end

  def test_check_in_guest__success
    result = @room_1.check_in_guest @guest_1
    expected = "No way! \"Forty Six & 2\", is my Jam!!!"
    assert_equal 3, @room_1.count_guests
    assert_equal result, expected
    assert_equal 3, @room_1.tab_count
  end

  def test_check_in_guest__fail_capacity
    @room_1.check_in_guest @guest_1
    result = @room_1.check_in_guest @guest_2
    assert_equal 3, @room_1.count_guests
    assert_nil result
    assert_equal 3, @room_1.tab_count
  end

  def test_check_in_guest__fail_money
    @guest_2.pay_money(7)
    result = @room_1.check_in_guest(@guest_2)
    assert_equal 2, @room_1.count_guests
    assert_nil result
    assert_equal 2, @room_1.tab_count
  end

  def test_guest_check_out__success
    @room_1.check_in_guest @guest_1
    @room_1.check_out_guest @guest_1
    assert_equal 2, @room_1.count_guests
    assert_equal 2, @room_1.tab_count
    assert_equal 10, @guest_1.money
  end

  def test_guest_check_out__fail
    @room_1.check_out_guest @guest_1
    assert_equal 2, @room_1.count_guests
    assert_equal 2, @room_1.tab_count
    assert_equal 20, @guest_1.money
  end

  def test_tab_count
    assert_equal 2, @room_1.tab_count
  end

  def test_buy_song__success
    @room_1.check_in_guest @guest_1
    @room_1.buy_song @guest_1, @song_1
    assert_equal 3, @room_1.playlist_size
    assert_equal 12, @room_1.get_tab(@guest_1).balance
  end

  def test_buy_song__fail_not_checked_in
    @room_1.buy_song @guest_1, @song_1
    assert_equal 2, @room_1.playlist_size
    assert_nil @room_1.get_tab @guest_1
  end

  def test_buy_song__fail_not_enough_money
    @room_1.check_in_guest @guest_2
    @room_1.buy_song @guest_2, @song_1
    assert_equal 2, @room_1.playlist_size
    assert_equal 10, @room_1.get_tab(@guest_2).balance
  end

  def test_play_next_song__songs_left
    result = @room_1.play_next_song
    expected = "Now playing \"Forty Six & 2\" by Tool"
    assert_equal expected, result
    assert_equal 1, @room_1.playlist_size
  end

  def test_play_next_song__no_songs_left
    2.times{@room_1.play_next_song}
    assert_nil @room_1.play_next_song
    assert_equal 0, @room_1.playlist_size
  end
end
