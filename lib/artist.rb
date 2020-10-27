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

    #each has method that set their own attribute and then different method that sets that same attribute for the other classes. 
    #postentially could try with different code path
    #try to not duplicate the state

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

      # TODO <<, multiset vs set, check if uniqness! yes. so won't need to use union
    end
    set
  end
end