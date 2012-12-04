require 'pinger'
require 'timecop'

describe Pinger do

  before do
    Timecop.scale(3600)
  end

  it "should instantiate an actor" do
    @p = Pinger.new(11,1, "32c68cae") 
    @p.class.should eq(Pinger)
  end 

end
