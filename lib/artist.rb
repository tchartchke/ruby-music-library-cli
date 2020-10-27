class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    self.name = name
    self.songs = []
    
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    self.class.all << self
    self
  end

  def self.create(name)
    self.new(name).save
  end

  def add_song(song)
    if song.artist.nil?
      if !self.songs.include?(song)
        self.songs << song
        song.instance_variable_set(:@artist, self)
      end
    end
    self
  end

  def genres
    set = Set.new
    self.songs.each do |song|
      set |= Set[song.genre]
    end
    set
  end
end