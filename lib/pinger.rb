require './lib/api.rb'

class Pinger < API

  def initialize(game_id, team_number, team_secret, chesster)
    @game_id = game_id
    @team_number = team_number
    @team_secret = team_secret
    @api = API.new
    @should_be_pinging = true
    @chesster = chesster

  end

  def connect
    puts 'Connecting to API poll'
    while true do
      if @should_be_pinging
        response = @api.poll(@game_id, @team_number, @team_secret)
        if response['ready'] == true
          @should_be_pinging = false
          @chesster.notify_of_new_move(response['lastmove'], response['lastmovenumber'])
        end
      end
      sleep(5)
    end
  end

  def carry_on
    puts 'Pinger has been told to carry on'
    @should_be_pinging = true
  end
end
