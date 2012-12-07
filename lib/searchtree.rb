require './models/move.rb'
require './models/position.rb'

class SearchTree

  attr_reader :current_state
  @@openings = {
    :black => [
      [:g8, :f6]  # alekhine defence
    ],
    :white => [
      []
    ]
  }

  def select_opening
    @@openings[@color].sample
  end

  def initialize(color=:white, use_opening=true, state=generate)
    @color = color
    @current_state = state
    @depth = 4
    @heuristic_bound = Float::INFINITY
    @nodes_visited = 0
    @move = 0
    @opening = select_opening
    @open_length = @opening.size
    @use_opening = use_opening
  end

  def generate
    position = Position.new
    position.new_game!
    position
  end

  def heuristic(position, player)
    # 1. Our pieces - opponents pieces
    # 2. Then weight pieces
    number_of_white_pieces = position.white_pieces.set_bits.length
    number_of_black_pieces = position.black_pieces.set_bits.length

    color = get_color(player)
    position.valuate(color) - position.valuate(color == :white ? :black : :white)
  end

  def get_color(player)
    raise 'player must equal 1 or -1' if player.abs != 1
    if player == 1
      @color
    else
      @color == :white ? :black : :white
    end
  end

  def minimax(position, depth, a, b, player)
    raise 'NIL is not a valid position' if position.nil?
    raise 'player must equal 1 or -1' if player.abs != 1
    @nodes_visited += 1
    if position.over?
      alpha = @heuristic_bound * -player
    elsif depth > 0
      if player == 1
        for move in Move.new(position).gen_all_moves(get_color(player))
          @nodes_visited += 1
          a = [a, minimax(position.move(move), depth-1, a, b, -player)].max
          if b <= a
            break
          end
        end
        alpha = a
      else
        for move in Move.new(position).gen_all_moves(get_color(player))
          @nodes_visited += 1
          b = [b, minimax(position.move(move), depth-1, a, b, -player)].min
          if b <= a
            break
          end
        end
        alpha = b
      end
    else
      alpha = heuristic(position, player)
    end
    return alpha
  end

  def search(position, depth=@depth, player=1)
    raise 'player must equal 1 or -1' if player.abs != 1

    # use an opening if its set
    if @use_opening && @move < @open_length
      puts @opening[@move]
      return @opening[@move]
    end
    @move += 1

    a = -Float::INFINITY
    b = Float::INFINITY
    res = [@heuristic_bound * -player, nil]
    Move.new(position).gen_all_moves(get_color(player)).each {|move|
      pos = position.move(move)
      alpha = minimax(pos, depth - 1, a, b, -player)
      test = [alpha, move]
      res = res[0] > test[0] ? res : test
    }
    puts 'alpha ' + res[0].to_s
    return res[1]
  end

end
