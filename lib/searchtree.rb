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

  def initialize(color=:white)
    @color = color
    @heuristic_bound = Float::INFINITY
    @move = 0
    @opening = @@openings[@color]
    @opening_length = @opening.size
  end

  def minimax(position, depth, a, b, player)
    if position.over? && player == -1
      alpha = @heuristic_bound
    elsif depth > 0
      if player == 1
        for move in Move.new(position).gen_all_moves(get_color(player))
          a = [a, minimax(position.move(move), depth-1, a, b, -player)].max
          if b <= a
            break
          end
        end
        alpha = a
      else
        for move in Move.new(position).gen_all_moves(get_color(player))
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
    # use an opening if its set
    if @move < @opening_length
      move = @opening[@move]
      return move
    end
    @move += 1

    a = -Float::INFINITY
    b = Float::INFINITY
    res = [@heuristic_bound * -player, nil]
    Move.new(position).gen_all_moves(get_color(player)).each {|move|
      pos = position.move(move)
      alpha = minimax(pos, depth - 1, a, b, -player)
      test = [alpha, move]
      if res[0] < test[0]
        res = test
      end
    }
    return res[1]
  end

end
