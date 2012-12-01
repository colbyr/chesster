require 'lib/api.rb'

class Pinger < API

  def ping(shouldFail=FALSE)
    if shouldFail
      self.not_ready
    else
      self.status
    end
  end

end
