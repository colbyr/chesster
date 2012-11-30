require 'test/unit'
require './models/bitboard.rb'

class BitboardTest < Test::Unit::TestCase
  def setup
    # Randomly chosen index values
    @bit_index_values = [0, 3, 7, 9, 17, 32, 42, 63]
    @board = Bitboard.new
  end

  def test_new
    a = Bitboard.new
    assert_not_nil a

    b = Bitboard.new(1)
    assert_not_nil b

    c = Bitboard.new(1<<63)
    assert_not_nil c
  end

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

    check_and(Bitboard::MaxValue)
    check_and(Bitboard.new(Bitboard::MaxValue))
  end

  def test_or
    b1 = Bitboard.new(0b01001)
    b2 = Bitboard.new(0b10110)
    result = b1 | b2
    assert_equal(0b11111, result.value)

    check_or(Bitboard::MinValue)
    check_or(Bitboard.new(Bitboard::MinValue))
  end

  def test_not
    full = Bitboard.new(Bitboard::MaxValue)
    empty = Bitboard.new(Bitboard::MinValue)
    assert_equal empty, ~full
    assert_equal full, ~empty

    @bit_index_values.each do |i| 
      full.clear!(i)
      empty.set!(i)
    end

    assert_equal empty, ~full
    assert_equal full, ~empty

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

  private
  def set_test_bits
    value = 0
    @bit_index_values.each do |n| 
      @board.set!(n)
      value += 1<<n  
    end
    value
  end

  def cleared_test_bits
    value = Bitboard::MaxValue
    @board = Bitboard.new(Bitboard::MaxValue)
    @bit_index_values.each do |n| 
      @board.clear!(n)
      value -= 1<<n  
    end
    value
  end

  def check_or(other)
    empty     = Bitboard.new(0)
    first     = Bitboard.new(1)
    last      = Bitboard.new(1<<63)
    next_last = Bitboard.new(1<<62)

    assert_equal      empty,      @board    | other 
    assert_equal      first,      first     | other
    assert_not_equal  empty,      first     | other
    assert_equal      next_last,  next_last | other
    assert_not_equal  first,      next_last | other
    assert_equal      last,       last      | other
    assert_not_equal  next_last,  last      | other
  end

  def check_and(other)
    empty     = Bitboard.new(0)
    first     = Bitboard.new(1)
    last      = Bitboard.new(1<<63)
    next_last = Bitboard.new(1<<62)

    assert_equal      empty,      @board    & other 
    assert_equal      first,      first     & other
    assert_not_equal  empty,      first     & other
    assert_equal      next_last,  next_last & other
    assert_not_equal  first,      next_last & other
    assert_equal      last,       last      & other
    assert_not_equal  next_last,  last      & other
  end

end
