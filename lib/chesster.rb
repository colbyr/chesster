require './lib/pinger.rb'
require './lib/ponger.rb'
require 'celluloid'

class Chesster
  include Celluloid
  
  attr_reader :notified
  attr_accessor :pinger

  def initialize(game_id, team_number, team_secret)
    @pinger = Pinger.new(game_id, team_number, team_secret)
    @ponger = Ponger.new
    register 
  end

  def notify_of_new_move(last_move, last_move_number)
     #TODO: Interrupt searching
    puts 'Got notified of new move: ' + last_move
  end

  private
  def register
    Actor[:chesster] = Actor.current
  end
end