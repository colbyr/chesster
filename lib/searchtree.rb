require './models/move.rb'
require './models/position.rb'

class SearchTree

  attr_reader :current_state

  def initialize(state=generate)
    @current_state = state
  end

  def generate
    position = Position.new
    position.new_game!
    position
  end

  def minimax(position, depth, whiteTurn)
    raise 'NIL is not a valid position' if position.nil?
    puts 'Current depth: ' + depth.to_s
    puts 'White turn? ' + whiteTurn.to_s

    @current_state = position

    #TODO Detect check/end of game
    if depth <=0
      puts 'depth <= 0!'
      return heuristic
    else
      alpha = -Float::INFINITY
      puts 'going in with alpha of: ' + alpha.to_s
      for move in Move.new(position).gen_all_moves(whiteTurn ? :white : :black)
        alpha = [alpha, -(minimax(position.move!(move), depth-1, !whiteTurn))].max
      end
      return alpha
    end
  end

  def heuristic
    # 1. Our pieces - opponents pieces
    # 2. Then weight pieces
    Random.rand(-1_000_000..1_000_000)
  end

end
