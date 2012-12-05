require './models/move.rb'
require './models/position.rb'

class SearchTree

  attr_reader :current_state

  def initialize(state=generate)
    @current_state = state
    @nodes_visited = 0
  end

  def generate
    position = Position.new
    position.new_game!
    position
  end

  def heuristic
    # 1. Our pieces - opponents pieces
    # 2. Then weight pieces
    Random.rand(-1_000_000..1_000_000)
  end

  def minimax(position, depth, whiteTurn)
    raise 'NIL is not a valid position' if position.nil?
    # puts 'Current depth: ' + depth.to_s
    # puts 'White turn? ' + whiteTurn.to_s
    @nodes_visited += 1
    result = [heuristic, position]

    @current_state = position

    # TODO Detect check/end of game
    if depth > 0
      # puts 'going in with alpha of: ' + result[0].to_s
      for move in Move.new(position).gen_all_moves(whiteTurn ? :white : :black)
        @nodes_visited += 1
        test = minimax(position.move!(move), depth-1, !whiteTurn)
        result = (result[0] > -(test[0])) ? result : test
      end
    end
    return result
  end

  def search(position)
    res = minimax(position, 6, true)
    puts
    puts 'alpha: ' + res[0].to_s
    puts 'nodes: ' + @nodes_visited.to_s
    puts 'position: ' + position.to_s
    return res[1]
  end

end
