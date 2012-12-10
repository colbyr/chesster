require './lib/api.rb'

class Ponger < API

  def initialize(game_id, team_number, team_secret)
    @game_id = game_id
    @team_number = team_number
    @team_secret = team_secret
    @api = API.new
  end

  def pong(move)
    puts 'Ponging move ' + move.to_s
    @api.move(@game_id, @team_number, @team_secret, move)
  end

end
