require 'csv'
require './lib/searchtree.rb'
require './lib/sharder.rb'
require './models/move.rb'
require './models/position.rb'

class Precalc

  def load
    CSV.foreach('./moves/' + @color.to_s + '.csv') do |row|
      @visited[row[0]] = row[1]
    end
  end

  def initialize(color, depth=6)
    @color = color
    @depth = depth
    @tree = SearchTree.new(:white)
    @next_moves = []
    @start = Position.new.new_game!
    @visited = Sharder.new
  end

  def gen_moves(count=10)
    i = 1
    precalc @start
    while !@next_moves.empty? and i <= count do
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
        @next_moves.push position.move(move)
      }
      res_s = Move.serialize(res)
      @visited[key] = res
      puts key.to_s + ',' + res_s.to_s
    end
  end

end
