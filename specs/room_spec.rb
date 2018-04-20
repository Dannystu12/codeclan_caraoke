require 'minitest/autorun'
require 'minitest/rg'
require_relative '../guest.rb'
require_relative '../song.rb'
require_relative '../room.rb'

class RoomTest < MiniTest::Test
  def setup
    guest_1 = Guest.new "Daniel"
    guest_2 = Guest.new "Connor"
    @guests = [guest_1, guest_2]

    @guest_1 = Guest.new "Gordon"

    song_1 = Song.new "Forty Six & 2", "Tool"
    song_2 = Song.new "Tornado of Souls", "Megadeth"
    @playlist = [song_1, song_2]

    @room_1 = Room.new "Metal Room", @guests, @playlist
    @room_2 = Room.new "Rap Room"
  end

  def test_get_room_name
    assert_equal "Metal Room", @room_1.name
  end

  def test_guest_count
    assert_equal 2, @room_1.count_guests
    assert_equal 0, @room_2.count_guests
  end

  def test_playlist_size
    assert_equal 2, @room_1.playlist_size
    assert_equal 0, @room_2.playlist_size
  end

  def test_check_in_guest
    @room_1.check_in_guest @guest_1
    assert_equal 3, @room_1.count_guests
  end

  def test_contains_guest__true
    @room_1.check_in_guest @guest_1
    assert_equal true, @room_1.contains_guest?(@guest_1)
    assert_equal true, @room_1.contains_guest?("Gordon")
  end

  def test_contains_guest__false
    assert_equal false, @room_1.contains_guest?(@guest_1)
    assert_equal false, @room_1.contains_guest?("Gordon")
  end

  def test_guest_check_out__success
    @room_1.check_in_guest @guest_1
    @room_1.check_out_guest @guest_1
    assert_equal 2, @room_1.count_guests

    @room_1.check_in_guest @guest_1
    @room_1.check_out_guest "Gordon"
    assert_equal 2, @room_1.count_guests
  end

  def test_guest_check_out__fail
    @room_1.check_out_guest @guest_1
    assert_equal 2, @room_1.count_guests

    @room_1.check_out_guest "Gordon"
    assert_equal 2, @room_1.count_guests
  end


end
