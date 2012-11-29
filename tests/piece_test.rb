require 'test/unit'
require './models/piece.rb'

class PieceTest < Test::Unit::TestCase
  def test_create_piece
    p = Piece.new
    assert(p)
  end

  def test_create_white_knight_piece
    p = Piece.new([:c1, :f1])
    assert(p)
  end

  def test_equal
    p1 = Piece.new([:c1, :f1])
    p2 = Piece.new([:c1, :f1])
    assert(p1 == p2)
  end

  def test_and
    p1 = Piece.new([:c1, :f1])
    p2 = Piece.new([:a2, :b2, :c2, :d2, :e2, :f2, :g2, :h2, :c1])
    p3 = p1 & p2
    assert(p3.set? :c1)
    assert(!(p3.set? :a2))
  end

  def test_or
    p1 = Piece.new([:c1, :f1])
    p2 = Piece.new
    p3 = p1 | p2
    assert(p3.set? :c1)
    assert(p3.set? :f1)
  end

  def test_not
    p1 = Piece.new([:c1, :f1])
    result = ~p1

    assert(!(result.set? Square.position(:c1)))
  end

  def test_xor
    p1 = Piece.new([:c1, :f1, :c2])
    p2 = Piece.new([:c1, :f1])

    result = p2 ^ p1

    assert(result.set? :c2)
  end

  def test_set
    p1 = Piece.new
    p1.set! :c1
    assert(p1.set? :c1)
  end

  def test_clear
    p1 = Piece.new([:c1])
    p1.clear! :c1
    assert(p1.clear? :c1)
  end

  def test_set_bits
    p1 = Piece.new([:c1, :f1])
    assert_equal([Square.position(:c1), Square.position(:f1)], p1.set_bits)
  end
  
end
