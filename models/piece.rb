require './models/square.rb'
require './models/bitboard.rb'

class Piece

  Type = [:king, :queen, :rook, :bishop, :knight, :pawn]
  Color = [:black, :white]

  attr_reader :bitboard

  def initialize(occupied=[])
    @bitboard = Bitboard.new
    occupied.each{|p| set!(p)}
  end

  def ==(other)
    @bitboard == other.bitboard
  end

  # Bitwise and
  def &(other)
    make_piece @bitboard & other.bitboard
  end

  # Bitwise or
  def |(other)
    make_piece @bitboard | other.bitboard
  end

  # Bitwise not
  def ~()
    Bitboard.new(~@bitboard)
  end

  # Bitwise xor
  def ^(other)
    make_piece @bitboard ^ other.bitboard
  end

  def set!(square)
    @bitboard.set!(Square.position(square))
  end

  def clear!(square)
    @bitboard.clear!(Square.position(square))
  end

  def set?(square)
    @bitboard.set?(Square.position(square))
  end

  def clear?(square)
    @bitboard.clear?(Square.position(square))
  end

  def set_bits
    @bitboard.set_bits
  end

  def gone?
    @bitboard.empty?
  end

  private
  def make_piece(bitboard)
    new_piece = Piece.new
    Square.each_value{|pos| new_piece.set!(Square.index(pos)) if bitboard.set?(pos)}
    new_piece
  end
end
