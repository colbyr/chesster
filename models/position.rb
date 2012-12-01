# A position contains all the pieces present on the board at a
# particular point in the game

require './models/piece.rb'

class Position
  attr_reader :white, :black

  def initialize(white={}, black={})
    @white = white
    @black = black
  end

  def new_game!
    @white[:pawn] = Piece.new([:a2, :b2, :c2, :d2, :e2, :f2, :g2, :h2])
    @white[:rook] = Piece.new([:a1, :h1])
    @white[:knight] = Piece.new([:b1, :g1])
    @white[:bishop] = Piece.new([:c1, :f1]) 
    @white[:king] = Piece.new([:e1])
    @white[:queen] = Piece.new([:d1])

    @black[:pawn] = Piece.new([:a7, :b7, :c7, :d7, :e7, :f7, :g7, :h7])
    @black[:rook] = Piece.new([:a8, :h8])
    @black[:knight] = Piece.new([:b8, :g8])
    @black[:bishop] = Piece.new([:c8, :f8])
    @black[:king] = Piece.new([:e8])
    @black[:queen] = Piece.new([:d8])
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
