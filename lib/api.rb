require 'httparty'

class API
  include HTTParty

  base_uri 'http://localhost:4567'

  def status(options={})
    self.class.get('/ready', options);
  end

  def not_ready(options={})
    self.class.get('/not_ready', options);
  end

end