require 'httparty'
require 'json'

class API
  include HTTParty

  base_uri 'http://www.bencarle.com/chess'

  def status(options={})
    self.class.get('/ready', options)
  end

  def not_ready(options={})
    self.class.get('/not_ready', options)
  end

  def poll(game_id, team_number, team_secret)
    JSON.parse(self.class.get("/poll/#{game_id}/#{team_number}/#{team_secret}/").parsed_response)
  end

  def move(game_id, team_number, team_secret, move_string)
    JSON.parse(self.class.get("/move/#{game_id}/#{team_number}/#{team_secret}/#{move_string}/").parsed_response)
  end

end
