require 'timecop'
require 'chesster'

describe Chesster do


  it "should register chesster" do
    @c = Chesster.new(11,1,"32c68cae")
    Celluloid::Actor[:chesster].should eq(@c)
  end

  it "should keep track of the state" do
    @c = Chesster.new(11,1,"32c68cae")
    @c.state.current_player.should eq(:white)
  end
    
  #TODO
  context "there is a new move" do
    it 'should make a new move' do
      @c = Chesster.new(11,1,"32c68cae")
      @c.notify_of_new_move('Pc7c8', 3)
      @c.state.current_position[:c7].should eq(nil)
    end
    #it 'should be notified of opponents moves' do
      #@c = Chesster.new(11,1,"32c68cae")
      #@c.notified.should eq(true)
    #end
  end

end
