require './lib/api.rb'
require './lib/state.rb'
require './lib/searchtree.rb'

class Chesster < API

  attr_reader :notified, :state
  attr_accessor :pinger

  def initialize(game_id, team_number, team_secret, color)
    @game_id = game_id
    @team_number = team_number
    @team_secret = team_secret
    @api = API.new
    @state = State.new
    @searcher = SearchTree.new(color)

    ping
  end

  def notify_of_new_move(last_move, last_move_number)
    if(last_move_number == 0)
      puts 'Starting game'
    else
      move = self.state.current_position.move_from_string last_move
      do_move(move)
    end

    new_move = find_move
    move_string = self.state.current_position.string_from_move(new_move)
    do_move(new_move)

    pong(move_string)
    ping

  end

  def find_move
    @searcher.search(self.state.current_position)
  end

  def do_move(move)
    self.state.current_position.move!(move)
  end

  private
  def ping
    while true do
      response = @api.poll(@game_id, @team_number, @team_secret)
      if response['ready'] == true
        notify_of_new_move(response['lastmove'], response['lastmovenumber'])
      end
      sleep(5)
    end
  end

  def pong(move)
    @api.move(@game_id, @team_number, @team_secret, move)
  end

end
