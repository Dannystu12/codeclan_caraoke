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

end
