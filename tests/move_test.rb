require 'test/unit'
require './models/position.rb'
require './models/move.rb'

# Help with testing of arrays of symbol
class Symbol
  def <=>(other)
    self.to_s <=> other.to_s
  end
end

class MoveTest < Test::Unit::TestCase
  def setup
    @new_game_move = Move.new(new_game_position)
    @initial_pawns = Move.new(game_position_initial_pawns)
  end

  def test_new
    assert_not_nil @new_game_move
    assert_not_nil Move::Attacks
    assert_not_nil Move::Attacks[:queen]
    assert_not_nil Move::Attacks[:queen][37]
    assert_not_nil Move::Attacks[:king]
    assert_not_nil Move::Attacks[:pawn]
    assert_not_nil Move::Attacks[:pawn][:black]
    assert_not_nil Move::Attacks[:pawn][:black][35]
    assert_not_nil Move::Attacks[:pawn][:white][35]
  end

  def test_new_game_gen_knight_moves
    white = [[:b1,:a3], [:b1,:c3], [:g1,:f3], [:g1,:h3]]
    black = [[:b8,:a6], [:b8,:c6], [:g8,:f6], [:g8,:h6]]

    check_expected_moves white, @new_game_move.gen_knight_moves(:white)
    check_expected_moves black, @new_game_move.gen_knight_moves(:black)
  end

  def test_new_game_gen_pawn_moves
    white = [ [:a2,:a3], [:a2,:a4], [:b2,:b3], [:b2,:b4] ,
              [:c2,:c3], [:c2,:c4], [:d2,:d3], [:d2,:d4] ,
              [:e2,:e3], [:e2,:e4], [:f2,:f3], [:f2,:f4] ,
              [:g2,:g3], [:g2,:g4], [:h2,:h3], [:h2,:h4] ]
    black = [ [:a7,:a6], [:a7,:a5], [:b7,:b6], [:b7,:b5] ,
              [:c7,:c6], [:c7,:c5], [:d7,:d6], [:d7,:d5] ,
              [:e7,:e6], [:e7,:e5], [:f7,:f6], [:f7,:f5] ,
              [:g7,:g6], [:g7,:g5], [:h7,:h6], [:h7,:h5] ]

    check_expected_moves white, @new_game_move.gen_pawn_moves(:white)
    check_expected_moves black, @new_game_move.gen_pawn_moves(:black)
  end

  def test_new_game_gen_rook_moves
    white = []
    black = []
    check_expected_moves white, @new_game_move.gen_rook_moves(:white, :rook)
    check_expected_moves black, @new_game_move.gen_rook_moves(:black, :rook)
  end

  def test_new_game_gen_bishop_moves
    white = []
    black = []
    check_expected_moves white, @new_game_move.gen_bishop_moves(:white, :bishop)
    check_expected_moves black, @new_game_move.gen_bishop_moves(:black, :bishop)
  end

  def test_new_game_gen_queen_moves
    white = []
    black = []
    check_expected_moves white, @new_game_move.gen_queen_moves(:white)
    check_expected_moves black, @new_game_move.gen_queen_moves(:black)
  end

  def test_new_game_gen_king_moves
    white = []
    black = []
    check_expected_moves white, @new_game_move.gen_king_moves(:white)
    check_expected_moves black, @new_game_move.gen_king_moves(:black)
  end

  def test_new_game_moves
    white = [ [:a2,:a3], [:a2,:a4], [:b2,:b3], [:b2,:b4] ,
              [:c2,:c3], [:c2,:c4], [:d2,:d3], [:d2,:d4] ,
              [:e2,:e3], [:e2,:e4], [:f2,:f3], [:f2,:f4] ,
              [:g2,:g3], [:g2,:g4], [:h2,:h3], [:h2,:h4] ,
              [:b1,:a3], [:b1,:c3], [:g1,:f3], [:g1,:h3] ]
    black = [ [:a7,:a6], [:a7,:a5], [:b7,:b6], [:b7,:b5] ,
              [:c7,:c6], [:c7,:c5], [:d7,:d6], [:d7,:d5] ,
              [:e7,:e6], [:e7,:e5], [:f7,:f6], [:f7,:f5] ,
              [:g7,:g6], [:g7,:g5], [:h7,:h6], [:h7,:h5] ,
              [:b8,:a6], [:b8,:c6], [:g8,:f6], [:g8,:h6] ]

    check_expected_moves white, @new_game_move.gen_all_moves(:white)
    check_expected_moves black, @new_game_move.gen_all_moves(:black)
  end


  def test01
    white = [ [:d1, :a1], [:d1, :a4], [:d1, :b1], [:d1, :b3],
              [:d1, :c1], [:d1, :c2], [:d1, :e1], [:d1, :e2],
              [:d1, :f1], [:d1, :f3], [:d1, :g4], [:d1, :g1],
              [:d2, :d3], [:d2, :d4], [:h1, :g1], [:h1, :g2],
              [:h2, :h3], [:h2, :h4] ]

    black = [ [:g2, :g1], [:g2, :h1], [:g4, :a4], [:g4, :b4],
              [:g4, :c4], [:g4, :d4], [:g4, :e4], [:g4, :f4],
              [:g4, :g3], [:g4, :h4], [:g5, :f4], [:g5, :f5],
              [:g5, :f6], [:g5, :g6], [:g5, :h4], [:g5, :h5],
              [:g5, :h6] ]
    move_01 = Move.new(game_position_01)
    check_expected_moves white, move_01.gen_all_moves(:white)
    check_expected_moves black, move_01.gen_all_moves(:black)
  end

  def test02
    white = [ [:c4, :a2], [:c4, :a4], [:c4, :a6], [:c4, :b3],
              [:c4, :b4], [:c4, :b5], [:c4, :c1], [:c4, :c2],
              [:c4, :c3], [:c4, :d3], [:c4, :d5], [:c4, :e2],
              [:c4, :e6], [:c4, :f1], [:c4, :f7], [:c4, :g8],
              [:c5, :b6], [:d4, :b3], [:d4, :b5], [:d4, :c2],
              [:d4, :c6], [:d4, :e2], [:d4, :e6], [:d4, :f3],
              [:e4, :b1], [:e4, :c2], [:e4, :c6], [:e4, :d3],
              [:e4, :d5], [:e4, :f3], [:e4, :g2], [:e4, :h1],
              [:f5, :f6], [:g4, :f3], [:g4, :f4], [:g4, :g3],
              [:g4, :g5], [:g4, :h3], [:g4, :h4], [:g4, :h5] ]

    black = [ [:a1, :b3], [:a1, :c2], [:b6, :b5], [:b6, :c5],
              [:b7, :a6], [:b7, :a8], [:b8, :a8], [:c8, :c7],
              [:c8, :d7], [:c8, :d8] ]
    move_02 = Move.new(game_position_02)
    check_expected_moves white, move_02.gen_all_moves(:white)
    check_expected_moves black, move_02.gen_all_moves(:black)
  end

  def test_initial_pawns_and_knights
    white = [ [:a2, :b3], [:b1, :a3], [:b1, :c3], [:b2, :a3],
              [:b2, :c3], [:c2, :b3], [:c2, :d3], [:d2, :c3],
              [:e2, :d3], [:e2, :e3], [:e2, :f3], [:g1, :f3],
              [:g1, :h3], [:g2, :f3], [:g2, :g3], [:g2, :g4],
              [:g2, :h3] ]
    black = [ [:a3, :b2], [:b3, :a2], [:b3, :c2], [:c3, :b2],
              [:c3, :d2], [:d3, :c2], [:d3, :e2], [:e4, :d4],
              [:e4, :d5], [:e4, :e3], [:e4, :e5], [:e4, :f4],
              [:e4, :f5], [:f3, :e2], [:f3, :g2], [:h3, :g2],]
    intial_pawns = Move.new(game_position_initial_pawns)
    check_expected_moves white, intial_pawns.gen_all_moves(:white)
    check_expected_moves black, intial_pawns.gen_all_moves(:black)
  end

  def test_white_pawn_promotion
    white = [ [:c6, :b5], [:c6, :b6], [:c6, :b7], [:c6, :c5],
              [:c6, :d5], [:c6, :d6], [:c6, :d7], [:c7, :d8],
              [:f7, :f8], [:f7, :g8], [:g7, :h8], [:h7, :g8] ]
    black = [ [:a8, :a7], [:a8, :b8], [:c8, :a7], [:c8, :b6],
              [:c8, :d6], [:c8, :e7], [:d8, :c7], [:d8, :e7], 
              [:d8, :f6], [:d8, :g5], [:d8, :h4], [:g8, :e7],
              [:g8, :f6], [:h6, :g5], [:h6, :g6], [:h6, :g7],
              [:h6, :h5], [:h6, :h7], [:h8, :h7] ]
    pawn_promoter = Move.new(game_white_pawn_promotion)
    check_expected_moves white, pawn_promoter.gen_all_moves(:white)
    check_expected_moves black, pawn_promoter.gen_all_moves(:black)
  end

  def test_black_pawn_promotion
    white = [ [:b1, :a1], [:b1, :b2], [:b1, :c1], [:d1, :c2], 
              [:d1, :e2], [:d1, :f3], [:d1, :g4], [:d1, :h5], 
              [:f1, :e1], [:f1, :e2], [:f1, :f2], [:f1, :g1], 
              [:f1, :g2], [:h1, :f2], [:h1, :g3] ]
    black = [ [:c2, :b1], [:c2, :c1], [:c2, :d1], [:h3, :g2],
              [:h3, :g3], [:h3, :g4], [:h3, :h4]]
    pawn_promoter = Move.new(game_black_pawn_promotion)
    check_expected_moves white, pawn_promoter.gen_all_moves(:white)
    check_expected_moves black, pawn_promoter.gen_all_moves(:black)
  end

  private
  def print_moves(moves)
    moves.sort.each{|mv| print "\n[:#{mv[0]}, :#{mv[1]}]"}
  end

  def new_game_position
    position = Position.new
    position.new_game!
    position
  end

  def game_position_01
    position = Position.new

    position.white[:pawn]   = Piece.new [:d2, :h2]
    position.white[:queen]  = Piece.new [:d1]
    position.white[:king]   = Piece.new [:h1]

    position.black[:pawn]   = Piece.new [:g2]
    position.black[:rook]   = Piece.new [:g4]
    position.black[:king]   = Piece.new [:g5]

    position
  end

  def game_position_02
    position = Position.new

    position.white[:pawn]   = Piece.new [:c5, :f5]
    position.white[:knight] = Piece.new [:d4]
    position.white[:bishop] = Piece.new [:e4]
    position.white[:queen]  = Piece.new [:c4]
    position.white[:king]   = Piece.new [:g4]

    position.black[:pawn]   = Piece.new [:b6, :c6]
    position.black[:knight] = Piece.new [:a1]
    position.black[:bishop] = Piece.new [:b7]
    position.black[:rook]   = Piece.new [:b8]
    position.black[:king]   = Piece.new [:c8]

    position
  end

  def game_position_initial_pawns
    position = Position.new

    position.white[:pawn]   = Piece.new [:a2, :b2, :c2, :d2, :e2, :f2, :g2, :h2]
    position.white[:knight] = Piece.new [:b1, :g1]
    position.white[:bishop] = Piece.new [:c1, :f1] 
    position.white[:rook]   = Piece.new [:a1, :h1]
    position.white[:queen]  = Piece.new [:d1]
    position.white[:king]   = Piece.new [:e1]

    position.black[:pawn]   = Piece.new [:a3, :b3, :c3, :d3, :f3, :h3]
    position.black[:king]   = Piece.new [:e4]

    position
  end

  # Some random opening game Old Benoni - Schmidt "Variation III-A"
  def game_position_benoni
    position = Position.new

    position.white[:pawn]   = Piece.new [:a2, :b2, :c2, :d5, :e4, :f2, :g2, :h2]
    position.white[:knight] = Piece.new [:c3, :g1]
    position.white[:bishop] = Piece.new [:c1, :f1] 
    position.white[:rook]   = Piece.new [:a1, :h1]
    position.white[:queen]  = Piece.new [:d1]
    position.white[:king]   = Piece.new [:e1]

    position.black[:pawn]   = Piece.new [:a7, :b7, :c5, :d6, :e7, :f7, :g6, :h7]
    position.black[:knight] = Piece.new [:b8, :g8]
    position.black[:bishop] = Piece.new [:c8, :g7]
    position.black[:rook]   = Piece.new [:a8, :h8]
    position.black[:queen]  = Piece.new [:d8]
    position.black[:king]   = Piece.new [:e8]

    position

  end

  #Kasparov, Gary 2849  --  Shirov, Alexei D 2718: 2001.01.23
  def game_position_kasparov_shirov
    position = Position.new

    position.white[:pawn]   = Piece.new [:a2, :b2, :c4, :d4, :f2, :g2, :h2]
    position.white[:knight] = Piece.new [:b1, :f3]
    position.white[:bishop] = Piece.new [:c1, :d3] 
    position.white[:rook]   = Piece.new [:a1, :f1]
    position.white[:queen]  = Piece.new [:c2]
    position.white[:king]   = Piece.new [:g1]

    position.black[:pawn]   = Piece.new [:a7, :b7, :c6, :d5, :f7, :g7, :h7]
    position.black[:knight] = Piece.new [:a6, :e4]
    position.black[:bishop] = Piece.new [:c8, :d6]
    position.black[:rook]   = Piece.new [:a8, :f8]
    position.black[:queen]  = Piece.new [:d8]
    position.black[:king]   = Piece.new [:g8]

    position
  end

  def game_white_pawn_promotion
    position = Position.new

    position.white[:pawn]   = Piece.new [:a7, :c7, :f7, :g7, :h7]
    position.white[:king]   = Piece.new [:c6]

    position.black[:knight] = Piece.new [:c8, :g8]
    position.black[:bishop] = Piece.new [:d8]
    position.black[:rook]   = Piece.new [:a8, :h8]
    position.black[:king]   = Piece.new [:h6]

    position
  end

  def game_black_pawn_promotion
    position = Position.new

    position.white[:knight] = Piece.new [:h1]
    position.white[:bishop] = Piece.new [:d1]
    position.white[:rook]   = Piece.new [:b1]
    position.white[:king]   = Piece.new [:f1]

    position.black[:pawn]   = Piece.new [:b2, :c2, :h2]
    position.black[:king]   = Piece.new [:h3]

    position
  end

  def check_expected_moves(expected, actual)
    assert_equal expected.size, actual.size
    assert_equal expected.sort, actual.sort
  end

end
