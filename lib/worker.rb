require 'celluloid'
require './lib/searchtree.rb'

class Worker
  include Celluloid

  def search(move, position, depth, a, b, player, color)
    color = color == :white ? :black : :white
    [SearchTree.minimax(position, depth, a, b, player, color), move]
  end

end
