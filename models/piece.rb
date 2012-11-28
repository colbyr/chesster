class Piece

  def initialize(color, name)
    @color = color
    @name = name
  end

  def to_s
    @color.to_s + @name.to_s
  end

end
