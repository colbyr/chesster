# A position contains all the pieces present on the board at a
# particular point in the game

require './models/piece.rb'

class Position
  attr_reader :white, :black

  def initialize(white={}, black={})
    @white = white
    @black = black
  end

  def [](square)
    raise ArgumentError, "#{square} is not a valid square, :a1,...,:h8 expected" unless Square.include?(square)
    @white.each { |piece, position| return [:white, piece] if position.set?(square) }
    @black.each { |piece, position| return [:black, piece] if position.set?(square) }
    nil # Really weird fall-through...
  end

  def set?(square)
    self[square]
  end

  def clear?(square)
    !self[square]
  end

  # Set square to be occupied by piece or nil to clear
  def []=(square, piece)
    raise ArgumentError unless Square.include?(square)

    return clear!(square) if piece.nil?

    raise ArgumentError unless Piece::Side.include?(piece[0])
    raise ArgumentError unless Piece::Type.include?(piece[1])

    if piece[0] == :white
      @white[piece[1]].set!(square)
    else
      @black[piece[1]].set!(square)
    end
    self[square]
  end

  def all_pieces
    self.white_pieces | self.black_pieces
  end

  def white_pieces
    all = Bitboard.new
    @white.each_value{|piece| all |= piece.bitboard }
    all
  end

  def black_pieces
    all = Bitboard.new
    @black.each_value{|piece| all |= piece.bitboard }
    all
  end

  private
  def clear!(square)
    piece = self[square]
    if piece[0] == :white
      @white[piece[1]].clear! square
    else
      @black[piece[1]].clear! square
    end
    nil
  end

end