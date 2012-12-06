require 'ponger'

describe Ponger do
  it "should instantiate a ponger object" do
    @p = Ponger.new(11, 1, "32c68cae")
    @p.class.should eq(Ponger)
  end

  #it "should notify the server of new moves" do
    #@p = Ponger.new(11, 1, "32c68cae")
    
  #end
end
