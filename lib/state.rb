require './models/position.rb'

class State

  attr_accessor :current_position
  attr_reader :current_player

  def initialize
    @current_player = :white
    @current_position = Position.new
    @current_position.new_game!
    @last_move_number = 0
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
