require './lib/api.rb'
require 'celluloid'

class Pinger < API
  include Celluloid

  def initialize(game_id, team_number, team_secret)
    register
    @game_id = game_id
    @team_number = team_number
    @team_secret = team_secret
    @api = API.new
    @should_be_pinging = true
    self.async.connect

  end

  def connect
    while true do
      if @should_be_pinging
        response = @api.poll(@game_id, @team_number, @team_secret)
        if response['ready'] == true
          @should_be_pinging = false
          Actor[:chesster].notify_of_new_move(response['lastmove'], response['lastmovenumber'])
        end
      end
      sleep(5)
    end
  end

  def carry_on
    @should_be_pinging = true
  end

  private
  def register
    Actor[:pinger] = Actor.current
  end

end
