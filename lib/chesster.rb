require './lib/pinger.rb'
require './lib/ponger.rb'
require './lib/state.rb'
require 'celluloid'

class Chesster
  include Celluloid
  
  attr_reader :notified, :state
  attr_accessor :pinger

  def initialize(game_id, team_number, team_secret)
    @pinger = Pinger.new(game_id, team_number, team_secret)
    @ponger = Ponger.new
    @state = State.new
    register 
  end

  def notify_of_new_move(last_move, last_move_number)
    #TODO: Interrupt searching
    #TODO: Check last move number and make sure we are in sync
    puts 'Got notified of new move: ' + last_move
    self.state.current_position = self.state.current_position.move_from_string last_move
  end

  private
  def register
    Actor[:chesster] = Actor.current
  end
end
