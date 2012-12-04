require 'timecop'
require 'chesster'

describe Chesster do


  it "should register chesster" do
    @c = Chesster.new(11,1,"32c68cae")
    Celluloid::Actor[:chesster].should eq(@c)
  end
    
  #TODO
  #context "there is a new move" do
    #it 'should be notified of opponents moves' do
      #@c = Chesster.new(11,1,"32c68cae")
      #@c.notified.should eq(true)
    #end
  #end

end
