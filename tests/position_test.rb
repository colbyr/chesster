require 'test/unit'
require './models/position.rb'
require './models/piece.rb'
require './models/square.rb'

class PositionTest < Test::Unit::TestCase
  def setup
    @new_game = new_game_position
  end

  def test_create_position
    assert_not_nil Position.new
  end

  def test_create_start_position
    position = Position.new
    position.new_game!

    assert_nil position[:d5]
    assert_nil position[:c6]

    assert_equal [:white, :pawn],     position[:a2]
    assert_equal [:white, :pawn],     position[:b2]
    assert_equal [:white, :pawn],     position[:c2]
    assert_equal [:white, :pawn],     position[:d2]
    assert_equal [:white, :pawn],     position[:e2]
    assert_equal [:white, :pawn],     position[:f2]
    assert_equal [:white, :pawn],     position[:g2]
    assert_equal [:white, :pawn],     position[:h2]
    assert_equal [:white, :rook],     position[:a1]
    assert_equal [:white, :rook],     position[:h1]
    assert_equal [:white, :knight],   position[:b1]
    assert_equal [:white, :knight],   position[:g1]
    assert_equal [:white, :bishop],   position[:c1]
    assert_equal [:white, :bishop],   position[:f1]
    assert_equal [:white, :queen],    position[:d1]
    assert_equal [:white, :king],     position[:e1]

    assert_equal [:black, :pawn],     position[:a7]
    assert_equal [:black, :pawn],     position[:c7]
    assert_equal [:black, :pawn],     position[:g7]
    assert_equal [:black, :king],     position[:e8]
    assert_equal [:black, :bishop],   position[:c8]
    assert_equal [:black, :knight],   position[:g8]

    assert_raise(ArgumentError) {position[:i1]}
  end

  def test_move!
    position = Position.new
    position.new_game!

    position.move!([:a2, :a3])

    assert_equal [:white, :pawn], position[:a3]
  end

  def test_square_set_accepts_nil
    @new_game[:d2] = nil
    @new_game[:e2] = nil

    assert_not_equal @new_game.white[:pawn], Piece.new([:a2, :b2, :c2, :d2, :e2, :f2, :g2, :h2]) 

    assert @new_game[:a2] == [:white, :pawn]
    assert @new_game[:f2] == [:white, :pawn]
    assert @new_game[:g1] == [:white, :knight]
    assert @new_game[:d1] == [:white, :queen]

    assert_nil @new_game[:d4] 
    assert_nil @new_game[:d2]

  end

  def test_white_pieces
    occupied = [:a2, :b2, :c2, :d2, :e2, :f2, :g2, :h2,
                :a1, :b1, :c1, :d1, :e1, :f1, :g1, :h1]

    check_expected_occupation occupied, @new_game.white_pieces
    check_expected_occupation [],       Position.new.white_pieces

  end

  def test_black_pieces
    occupied = [:a8, :b8, :c8, :d8, :e8, :f8, :g8, :h8, 
                :a7, :b7, :c7, :d7, :e7, :f7, :g7, :h7]

    check_expected_occupation occupied, @new_game.black_pieces
    check_expected_occupation [],       Position.new.black_pieces
  end

  def test_all_pieces
    occupied = [:a8, :b8, :c8, :d8, :e8, :f8, :g8, :h8, 
                :a7, :b7, :c7, :d7, :e7, :f7, :g7, :h7,
                :a2, :b2, :c2, :d2, :e2, :f2, :g2, :h2,
                :a1, :b1, :c1, :d1, :e1, :f1, :g1, :h1]

    check_expected_occupation occupied, @new_game.all_pieces
    check_expected_occupation [],       Position.new.all_pieces
  end

  def test_set?
    occupied = [:a8, :b8, :c8, :d8, :e8, :f8, :g8, :h8, 
                :a7, :b7, :c7, :d7, :e7, :f7, :g7, :h7,
                :a2, :b2, :c2, :d2, :e2, :f2, :g2, :h2,
                :a1, :b1, :c1, :d1, :e1, :f1, :g1, :h1]

    check_expected_occupation occupied, @new_game.all_pieces
    check_expected_occupation [],       Position.new.all_pieces
    Square.each_key do |square|
      occupied.include?(square) ? assert(@new_game.set?(square)) : assert(@new_game.clear?(square))
    end
  end

  def test_deep_copy
    p1 = Position.new
    p1.new_game!
    p2 = p1.deep_copy
    assert_equal((p2 != p1), true)
  end

  def test_move_from_string
    p1 = Position.new
    p1.new_game!
    res = p1.move_from_string('Pd2d3')
    assert res == [:d2, :d3]
  end

  def test_string_from_move
    p = Position.new
    p.new_game!
    assert p.string_from_move([:a2, :a3]) == 'Pa2a3'
  end

  private
  def new_game_position
    position = Position.new

    position.white[:pawn] = Piece.new([:a2, :b2, :c2, :d2, :e2, :f2, :g2, :h2])
    position.white[:rook] = Piece.new([:a1, :h1])
    position.white[:knight] = Piece.new([:b1, :g1])
    position.white[:bishop] = Piece.new([:c1, :f1]) 
    position.white[:king] = Piece.new([:e1])
    position.white[:queen] = Piece.new([:d1])

    position.black[:pawn] = Piece.new([:a7, :b7, :c7, :d7, :e7, :f7, :g7, :h7])
    position.black[:rook] = Piece.new([:a8, :h8])
    position.black[:knight] = Piece.new([:b8, :g8])
    position.black[:bishop] = Piece.new([:c8, :f8])
    position.black[:king] = Piece.new([:e8])
    position.black[:queen] = Piece.new([:d8])

    position

  end

  def check_expected_occupation(expected, current)

    Square.each do |square, bit| 
      expected.include?(square) ? assert(current.set?(bit)) : assert(current.clear?(bit))
    end

  end

end
