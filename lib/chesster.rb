require './lib/pinger.rb'
require './lib/ponger.rb'
require './lib/state.rb'
require './lib/searchtree.rb'
require 'celluloid'

class Chesster
  include Celluloid
  
  attr_reader :notified, :state
  attr_accessor :pinger

  def initialize(game_id, team_number, team_secret)
    @pinger = Pinger.new(game_id, team_number, team_secret)
    @ponger = Ponger.new(game_id, team_number, team_secret)
    @state = State.new
    @searcher = SearchTree.new
    
    register 
  end

  def notify_of_new_move(last_move, last_move_number)
    #TODO: Interrupt searching
    #TODO: Check last move number and make sure we are in sync
    puts 'Got notified of new move: ' + last_move
    move = self.state.current_position.move_from_string last_move
    do_move(move) 
    puts 'State is now: '
    self.state.current_position.to_s
    do_move(find_move)

    puts 'Moved:'
    print self.state.current_position.to_s
  end

  def find_move
    @searcher.search(self.state.current_position)
  end

  def do_move(move)
    self.state.current_position.move!(move)
  end

  private
  def register
    Actor[:chesster] = Actor.current
  end
end
