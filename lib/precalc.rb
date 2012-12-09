require 'csv'
require './lib/searchtree.rb'
require './lib/sharder.rb'
require './models/move.rb'
require './models/position.rb'

class Precalc

  def initialize(color, depth=6)
    @color = color
    @continue = true
    @depth = depth
    @tree = SearchTree.new(@color)
    @next_moves = []
    @start = Position.new.new_game!
    @visited = Sharder.new
  end

  def gen_moves()
    i = 1
    precalc @start
    while @continue
      precalc @next_moves.pop
      i += 1
    end
    @next_moves = []
  end

  def other_color
    @color == :white ? :black : :white
  end

  def precalc(position)
    raise 'position is NIL' if position.nil?
    key = position.serialize
    if !@visited.include?(key)
      res = @tree.search(position, @depth)
      Move.new(position.move(res)).gen_all_moves(other_color).each { |move|
        if move[0].nil? or move[1].nil? or !Square.include?(move[0]) or !Square.include?(move[1])
          puts position.to_s
          raise "#{move} is invalid"
        end
        @next_moves.push position.move(move)
      }
      res_s = Move.serialize(res)
      @visited[key] = res
      puts key.to_s + ',' + res_s.to_s
    end
  end

  def stop
    @continue = false
  end

end
