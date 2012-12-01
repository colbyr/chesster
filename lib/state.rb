class State

  attr_reader :current_player
  
  def initialize
    @current_player = :white
  end
  
  def can_castle
    false 
  end

  def switch_current_turn!
    if @current_player == :white
      @current_player = :black
    else
      @current_player = :white
    end
  end

end
