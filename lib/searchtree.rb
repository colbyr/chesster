require 'celluloid'
require './models/move.rb'
require './models/position.rb'
require './lib/worker.rb'

class SearchTree

  attr_reader :current_state

  @@depth = 4
  @@heuristic_bound = Float::INFINITY

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

  def self.heuristic(position, player, color)
    # 1. Our pieces - opponents pieces
    # 2. Then weight pieces
    number_of_white_pieces = position.white_pieces.set_bits.length
    number_of_black_pieces = position.black_pieces.set_bits.length

    position.valuate(color) - position.valuate(color == :white ? :black : :white)
  end

  def initialize(color)
    @color = color
    @move = 0
    @opening = @@openings[@color]
    @opening_length = @opening.size
    @pool = Worker.pool
  end

  def self.minimax(position, depth, a, b, player, color)
    if player != 1
      color == :white ? :black : :white
    end
    if position.over?
      alpha = @@heuristic_bound * -player
    elsif depth > 0
      if player == 1
        for move in Move.new(position).gen_all_moves(color)
          a = [a, self.minimax(position.move(move), depth-1, a, b, -player, color)].max
          break if b <= a
        end
        alpha = a
      else
        for move in Move.new(position).gen_all_moves(color == :white ? :black : :white)
          b = [b, self.minimax(position.move(move), depth-1, a, b, -player, color)].min
          break if b <= a
        end
        alpha = b
      end
    else
      alpha = self.heuristic(position, player, color)
    end
    return alpha
  end

  def search(position, depth=@@depth, player=1)
    if @move < @opening_length
      move = @opening[@move]
      @move += 1
      return move
    end

    a = -@@heuristic_bound
    b = @@heuristic_bound
    futures = Move.new(position).gen_all_moves(get_color(player)).map {|move|
      @pool.future.search(move, position.move(move), depth - 1, a, b, -player, get_color(player))
    }
    moves = futures.map(&:value)
    res = (moves.inject([@@heuristic_bound * -player, nil]) { |res, test|
      res[0] <= test[0] ? test : res
    })
    puts "alpha: #{res}"
    res[1]
  end

end
