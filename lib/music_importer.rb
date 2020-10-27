class MusicImporter
  attr_accessor :path
  
  def initialize(path)
    self.path = path
  end

  def files
    #does children get directories?
    Dir.children(self.path)
  end

  def import
    files.collect { |file| Song.create_from_filename(file) }
  end

end