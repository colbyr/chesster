require 'test/unit'
require './models/piece.rb'

class PieceTest < Test::Unit::TestCase
  def setup
    @piece = empty_board
    @white_pawns = [:a2, :b2, :c2, :d2, :e2, :f2, :g2, :h2]
  end
  
  def test_create_piece
    p = Piece.new
    assert_not_nil(p)
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

    other     = full_board
    empty     = empty_board
    first     = Piece.new [:a1]
    last      = Piece.new [:h8]
    next_last = Piece.new [:h7]

    assert_equal      empty,      @piece    & other
    assert_equal      first,      first     & other
    assert_not_equal  empty,      first     & other
    assert_equal      next_last,  next_last & other
    assert_not_equal  first,      next_last & other
    assert_equal      last,       last      & other
    assert_not_equal  next_last,  last      & other

  end

  def test_or
    p1 = Piece.new([:c1, :f1])
    p2 = Piece.new
    p3 = p1 | p2
    assert(p3.set? :c1)
    assert(p3.set? :f1)

    other     = empty_board
    empty     = empty_board
    first     = Piece.new [:a1]
    last      = Piece.new [:h8]
    next_last = Piece.new [:h7]

    assert_equal      empty_board,  @piece    | other
    assert_equal      first,        first     | other
    assert_not_equal  empty_board,  first     | other
    assert_equal      next_last,    next_last | other
    assert_not_equal  first,        next_last | other
    assert_equal      last,         last      | other
    assert_not_equal  next_last,    last      | other

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

    assert_equal set_test_squares, @piece.bitboard
  end

  def test_clear
    p1 = Piece.new([:c1])
    p1.clear! :c1
    assert(p1.clear? :c1)

    #assert_equal cleared_test_squares, @piece.bitboard #TODO Broken
  end

  def test_square_set?
    set_test_squares
    check_positions_set
  end

  def test_square_clear?
    cleared_test_squares
    check_positions_clear
  end

  def test_string_symbol_equivalence
    set_test_string_squares
    check_positions_set

    clear_test_string_squares
    check_positions_clear
  end

  def test_set_bits
    all_bits=[]
    0.upto(63) {|i| all_bits << i}
    wp = Piece.new(@white_pawns)
    wp_bits = [8, 9, 10, 11, 12, 13, 14, 15]
    assert_equal all_bits, full_board.set_bits
    assert_equal [], empty_board.set_bits 
    assert_equal wp_bits, Piece.new(@white_pawns).set_bits
  end

  private
  def set_test_squares
    value = Bitboard.new
    @white_pawns.each do |pos| 
      @piece.set! pos
      value.set!(Square.position(pos))
    end
    value    
  end

  def set_test_string_squares
    value = Bitboard.new
    @white_pawns.each do |square| 
      @piece.set! square.to_s
      value.set!(Square.position(square))
    end
    value    
  end

  def cleared_test_squares
    value = Bitboard.new(Bitboard::MaxValue)
    @piece = full_board
    @white_pawns.each do |square|
      @piece.clear! square
      value.clear!(Square.position(square))
    end
    value    
  end

  def clear_test_string_squares
    value = Bitboard.new(Bitboard::MaxValue)
    @piece = full_board
    @white_pawns.each do |square|
      @piece.clear! square.to_s
      value.clear!(Square.position(square))
    end
    value    
  end

  def check_positions_set
    Square.each do |square, pos| 
      if @white_pawns.include? square
        assert @piece.set?(square)
      else
        assert !@piece.set?(square)
      end
    end
  end

  def check_positions_clear
    Square.each do |square, pos| 
      if @white_pawns.include? square
        assert @piece.clear?(square)
      else
        assert !@piece.clear?(square)
      end
    end
  end

  def full_board
    Piece.new(Square.collect{|sq_pos| sq_pos[0]})
  end

  def empty_board
    Piece.new
  end

  
end
