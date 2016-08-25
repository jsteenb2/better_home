class GruffAPI
  attr_reader :image

  def initialize
    @gruff = Gruff::Line.new 
  end

  # Takes a hash, assigning to a label to each index for the graph.
  def labels=(labels)
    @gruff.labels = labels
  end

  # Takes a symbol and an array of values, and saves that row, with
  # its data per point in the timeline.
  def data=(row,values)
    @gruff.data = row, values
  end

  # Takes a filename string, and writes an image to the root.
  def write(filename)
    @image = @gruff.write(filename)
  end

end