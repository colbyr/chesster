require './lib/api.rb'
require 'celluloid'

class Pinger < API
  include Celluloid

  def initialize(game_id, team_number, team_secret)
    @game_id = game_id
    @team_number = team_number
    @team_secret = team_secret
    @api = API.new
    self.async.connect
  end

  def connect
    while true do
      response = @api.poll(@game_id, @team_number, @team_secret)
      if response['ready'] == true
        Actor[:chesster].notify_of_new_move(response)
      end 
      sleep(300)
    end
  end

end
