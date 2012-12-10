require './models/move.rb'

class Visited

  def initialize(limit=2)
    @limit = 2
    @pair = []
  end

  def include?(move)
    nxt = serialize(move)
    @pair.each { |mv|
      return if found = (mv[:move] == nxt[:move] and mv[:next])
    }
    false
  end

  # [[:to, :from], alpha]
  def add!(move)
    @pair.push serialize(move)
    @pair.size > @limit ? @pair.shift : nil
    move
  end

  private
  def serialize(move)
    {:alpha => move[0], :move => Move.serialize(move[1])}
  end

end
