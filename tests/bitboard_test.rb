require 'test/unit'
require './models/bitboard.rb'

class BitboardTest < Test::Unit::TestCase
  def test_create_blank_bitboard
    b = Bitboard.new
    assert_equal(0, b.value)
  end

  def test_create_white_knights_bitboard
    white_knights = 0b01000010_00000000_00000000_00000000_00000000_00000000_00000000_00000000
    b = Bitboard.new(white_knights)
    assert_equal(white_knights, b.value)
  end

  def test_board_equality
    white_knights = 0b01000010_00000000_00000000_00000000_00000000_00000000_00000000_00000000
    b = Bitboard.new(white_knights)
    same = Bitboard.new(white_knights)
    other = Bitboard.new
    assert(b == same)
    assert(!(b == other))
  end

  def test_and
    white_knights = 0b01000010_00000000_00000000_00000000_00000000_00000000_00000000_00000000
    b1 = Bitboard.new(white_knights)
    white_knights_less = 0b01000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000
    b2 = Bitboard.new(white_knights_less)
    result = b1 & b2
    assert_equal(result, b2)
  end

  def test_or
    b1 = Bitboard.new(0b01001)
    b2 = Bitboard.new(0b10110)
    result = b1 | b2
    assert_equal(0b11111, result.value)
  end

  def test_not
    b1 = Bitboard.new(0b010000)
    b2 = Bitboard.new(0b101111)

    assert(b2 = ~b1)
  end

  def test_xor
    b1 = Bitboard.new(0b001011)
    b2 = Bitboard.new(0b001001)
    b3 = Bitboard.new(0b000010)

    assert((b1 ^ b2) == b3)
  end

  def test_set
    b1 = Bitboard.new(0b000000)
    b1.set! 1

    assert_equal(0b000010, b1.value)
    assert(b1.set? 1)
  end

  def test_clear
    b1 = Bitboard.new(0b0000010)
    b1.clear! 1

    assert_equal(0b000000, b1.value)
    assert(!(b1.set? 1))
  end

  def test_set_bits
    b1 = Bitboard.new(0b100001)
    assert_equal([0, 5], b1.set_bits)
    b1.clear! 0
    b1.clear! 5
    assert_equal([], b1.set_bits)
  end

end
