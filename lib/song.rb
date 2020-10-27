class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = [] #TODO more descriptive naming

  def initialize(name, artist = nil, genre = nil)
    self.name = name
    # binding.pry
    self.artist = artist if !artist.nil?
    self.genre = genre if !genre.nil?
    # can guard against nil in the artist=/genre= setter
  end

  def self.all
    @@all
  end

  def artist=(artist) #TODO maybe artist should store things and not the song.
    @artist = artist.add_song(self)
  end

  def genre=(genre)
    genre.songs << self if !genre.songs.include?(self)
    @genre = genre
  end

  def save
    self.class.all << self #@@all should be fine? prolly. since you're in the class
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
    
    # this will overwrite the orginal to be the cover. haha. 
    # song  = find_or_create_by_name(song_name)
    # song.artist = new_artist
    # song.genre = new_genre

    #does not allow covers. could find by name and then check if the artists and genre matches
    Song.new(song_name, new_artist, new_genre) if !Song.find_by_name(song_name)
  end

  def self.create_from_filename(file)
    Song.new_from_filename(file).save
  end

end