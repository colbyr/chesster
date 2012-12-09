require './models/move.rb'
require './models/position.rb'

class SearchTree

  attr_reader :current_state

  @@depth = 4

  @@openings = {
    :black => [ # nimzo-indian
      [:g8, :f6],
      [:e7, :e6]
    ],
    :white => [ # queen's pawn game
      [:e2, :e3],
      [:d2, :d4]
    ]
  }

  def get_color(player)
    raise 'player must equal 1 or -1' if player.abs != 1
    if player == 1
      @color
    else
      @color == :white ? :black : :white
    end
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

  def initialize(color=:white, use_opening=true, logging=false)
    @color = color
    @heuristic_bound = Float::INFINITY
    @logging = logging
    @nodes_visited = 0
    @move = 0
    @opening = select_opening
    @opening_length = @opening.size
    @use_opening = use_opening
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

  def search(position, depth=@@depth, player=1)
    raise 'player must equal 1 or -1' if player.abs != 1
    @nodes_visited = 0
    # use an opening if its set
    if @use_opening and @move < @opening_length
      move = @opening[@move]
      @move += 1
      return move
    else
      @move += 1
    end

    a = -Float::INFINITY
    b = Float::INFINITY
    res = [@heuristic_bound * -player, nil]
    Move.new(position).gen_all_moves(get_color(player)).each {|move|
      pos = position.move(move)
      alpha = minimax(pos, depth - 1, a, b, -player)
      test = [alpha, move]
      res = res[0] > test[0] ? res : test
      @nodes_visited
    }
    if @logging
      puts 'SEARCH COMPLETE'
      puts '- - - - - - - - - - - - - - - - -'
      puts 'alpha: ' + res[0].to_s
      puts ' move: ' + res[1].to_s
      puts 'nodes: ' + @nodes_visitied.to_s
      puts
    end
    return res[1]
  end

  def select_opening
    @@openings[@color].sample
  end

end
