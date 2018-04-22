require 'minitest/autorun'
require 'minitest/rg'
require_relative '../song.rb'

class SongTest < MiniTest::Test
  def setup
    @song_1 = Song.new "Forty Six & 2", "Tool"
  end

  def test_get_title
    assert_equal "Forty Six & 2", @song_1.title
  end

  def test_get_artist
    assert_equal "Tool", @song_1.artist
  end

  def test_equals__true
    assert_equal true, @song_1 == @song_1
    song = Song.new "Forty Six & 2", "Tool"
    assert_equal true, @song_1 == song
  end

  def test_equals__false
    song = Song.new "Tornado of Souls", "Megadeth"
    assert_equal false, @song_1 == song
    assert_equal false, @song_1 == "test"
  end
end
