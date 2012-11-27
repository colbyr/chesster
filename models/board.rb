Piece = Struct.new(:color, :name);

class Board

  @@char_map = {
    'a' => 0,
    'b' => 1,
    'c' => 2,
    'd' => 3,
    'e' => 4,
    'f' => 5,
    'g' => 6,
    'h' => 7
  }

  def initialize
    @state  = [
      [Piece.new(:w, :R), Piece.new(:w, :P), :e, :e, :e, :e, Piece.new(:b, :P), Piece.new(:b, :R)], # a
      [Piece.new(:w, :N), Piece.new(:w, :P), :e, :e, :e, :e, Piece.new(:b, :P), Piece.new(:b, :N)], # b
      [Piece.new(:w, :B), Piece.new(:w, :P), :e, :e, :e, :e, Piece.new(:b, :P), Piece.new(:b, :B)], # c
      [Piece.new(:w, :Q), Piece.new(:w, :P), :e, :e, :e, :e, Piece.new(:b, :P), Piece.new(:b, :Q)], # d
      [Piece.new(:w, :K), Piece.new(:w, :P), :e, :e, :e, :e, Piece.new(:b, :P), Piece.new(:b, :K)], # e
      [Piece.new(:w, :B), Piece.new(:w, :P), :e, :e, :e, :e, Piece.new(:b, :P), Piece.new(:b, :B)], # f
      [Piece.new(:w, :N), Piece.new(:w, :P), :e, :e, :e, :e, Piece.new(:b, :P), Piece.new(:b, :N)], # g
      [Piece.new(:w, :R), Piece.new(:w, :P), :e, :e, :e, :e, Piece.new(:b, :P), Piece.new(:b, :R)]  # h
    ]
  end

  def alpha(char)
    @@char_map[char]
  end

  def get(coord)
    @state[self.alpha(coord[0])][self.num(coord[1])];
  end

  def set(coord, new)
    current = @state[self.alpha(coord[0])][self.num(coord[1])];
    @state[self.alpha(coord[0])][self.num(coord[1])] = new;
    current
  end

  def move(from, to)
    piece = self.set(from, :e)
    self.set(to, piece)
  end

  def num(char)
    char.to_i - 1
  end

end
