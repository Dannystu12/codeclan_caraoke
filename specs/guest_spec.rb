require 'minitest/autorun'
require 'minitest/rg'
require_relative '../guest.rb'
require_relative '../song.rb'

class GuestTest < MiniTest::Test
  def setup
    @guest_1 = Guest.new "Daniel", 10
    @song_1 = Song.new "Am I Evil?", "Diamond Head"
    @guest_2 = Guest.new "Gordon", 10, @song_1

    song_2 = Song.new "Forty Six & 2", "Tool"
    song_3 = Song.new "Tornado of Souls", "Megadeth"
    @playlist = [song_2, song_3]
  end

  def test_get_name
    assert_equal "Daniel", @guest_1.name
  end

  def test_get_money
    assert_equal 10, @guest_1.money
  end

  def test_get_favourite_song
    assert_nil @guest_1.favourite_song
    assert_equal @song_1, @guest_2.favourite_song
  end

  def test_can_afford__true
    assert_equal true, @guest_1.can_afford?(10)
  end

  def test_can_afford__false
    assert_equal false, @guest_1.can_afford?(11)
    assert_equal false, @guest_1.can_afford?(-1)
  end

  def test_pay_money__success
    @guest_1.pay_money 5.40
    assert_equal 4.60, @guest_1.money
  end

  def test_pay_money__fail
    @guest_1.pay_money 100
    assert_equal 10, @guest_1.money

    @guest_1.pay_money -1
    assert_equal 10, @guest_1.money
  end

  def test_check_playlist__success
    @playlist << @song_1
    expected = "No way! \"Am I Evil?\", is my Jam!!!"
    assert_equal expected, @guest_2.check_playlist(@playlist)
  end

  def test_check_playlist__fail
    assert_nil @guest_1.check_playlist(@playlist)
    assert_nil @guest_2.check_playlist(@playlist)
  end

  def test_equals__true
    assert_equal true, @guest_2 == @guest_2
    guest = Guest.new "Gordon", 10, @song_1
    assert_equal true, @guest_2 == guest
  end

  def test_equals__false
    assert_equal false, @guest_1 == @guest_2
    assert_equal false, @guest_1 == "test"
  end
end
