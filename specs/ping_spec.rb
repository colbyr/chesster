require 'pinger'

describe Pinger do

  it "should instantiate an actor" do
    @p = Pinger.new(11,1, "32c68cae") 
    @p.class.should eq(Pinger)
  end

end
