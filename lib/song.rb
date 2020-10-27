class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    self.name = name
    self.artist = artist if !artist.nil?
    self.genre = genre if !genre.nil?
    
  end

  def self.all
    @@all
  end

  def artist=(artist)
    @artist = artist.add_song(self)
  end

  def genre=(genre)
    genre.songs << self if !genre.songs.include?(self)
    @genre = genre
  end

  def save
    self.class.all << self
    self
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    self.new(name).save
  end

  def self.new_from_filename(file)

    # gsub for frst split
    artist_name, song_name, genre_name = file.split(".")[0].split(" - ")

    new_artist = Artist.find_or_create_by_name(artist_name)
    new_genre = Genre.find_or_create_by_name(genre_name)
    
    Song.new(song_name, new_artist, new_genre) if !Song.find_by_name(song_name)
  end

  def self.create_from_filename(file)
    Song.new_from_filename(file).save
  end

end