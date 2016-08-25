class GruffPie
  attr_reader :image

  def initialize
    @gruff = Gruff::Pie.new 
  end

  def title=(title)
    @gruff.title = title
  end

  def set_data(row,value)
    @gruff.data(row,value)
  end

  def write(filename)
    @image = @gruff.write("#{Rails.root}/app/assets/images/chart/#{filename}")
  end

end