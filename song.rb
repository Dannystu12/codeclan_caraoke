class Song
  attr_reader :title, :artist
  def initialize title, artist
    @title, @artist = title, artist
  end

  def == obj
    obj.class == Song && obj.title == @title && obj.artist == @artist
  end
end
