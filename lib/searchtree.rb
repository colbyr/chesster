require './models/move.rb'
require './models/position.rb'

class SearchTree

  attr_reader :current_state

  def initialize(state=generate)
    @color = :white
    @current_state = state
    @depth = 3
    @heuristic_bound = 1000000
    @nodes_visited = 0
  end

  def generate
    position = Position.new
    position.new_game!
    position
  end

  def heuristic(position)
    # 1. Our pieces - opponents pieces
    # 2. Then weight pieces
    number_of_white_pieces = position.white_pieces.set_bits.length
    number_of_black_pieces = position.black_pieces.set_bits.length

    if @color == :white
      number_of_white_pieces - number_of_black_pieces
    else
      number_of_black_pieces - number_of_white_pieces
    end
  end

  def get_color(player)
    raise 'player must equal 1 or -1' if player.abs != 1
    if player == 1
      @color
    else
      @color == :white ? :black : :white
    end
  end

  def minimax(position, depth, player)
    raise 'NIL is not a valid position' if position.nil?
    raise 'player must equal 1 or -1' if player.abs != 1
    @nodes_visited += 1
    # TODO Detect check/end of game
    if depth > 0
      alpha = @heuristic_bound * -player
      next_player = player * -1
      for move in Move.new(position).gen_all_moves(get_color(player))
        @nodes_visited += 1
        test = minimax(position.move!(move), depth-1, next_player)
        opts = [alpha, test]
        alpha = (player == 1) ? opts.max : opts.min
        if depth == 100
          # puts (player == 1 ? 'max' : 'min') + ': from ' + opts.to_s + ' chose ' + alpha.to_s
        end
      end
    else
      alpha = heuristic position
    end
    return alpha
  end

  def search(position, player=1)
    raise 'player must equal 1 or -1' if player.abs != 1
    res = [@heuristic_bound * player, nil]
    Move.new(position).gen_all_moves(get_color(player)).each {|move|
      pos = position.move!(move)
      alpha = minimax(pos, @depth - 1, -player)
      test = [alpha, move]
      res = res[0] < test[0] ? res : test
    }
    puts
    puts 'alpha: ' + res[0].to_s
    puts 'nodes: ' + @nodes_visited.to_s
    return res[1]
  end

end
