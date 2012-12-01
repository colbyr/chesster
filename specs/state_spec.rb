require 'state'

describe State do
  context 'when castling is not possible' do

    before(:each) do
      @state = mock(State)
      @state.stub!(:can_castle).and_return(false)
    end

    it "should indicate that castling is not possible" do
      @state.can_castle.should eq(false)
    end

  end

  context 'when castling is possible' do
    
    before(:each) do
      @state = mock(State)
      @state.stub!(:can_castle).and_return(true)
    end

    it "should indicate castling is possible" do
      @state.can_castle.should eq(true)
    end

  end

  context 'when it is white turn' do
    it "should indiciate that it is white turn" do
      @state = State.new
      @state.current_player.should eq(:white)
    end

    it "should change to black turn when signaled to switch" do
      @state = State.new
      @state.switch_current_turn!
      @state.current_player.should eq(:black)
    end
  end

  context 'when it is black turn' do
    it "should indicate that it is black turn" do
      @state = State.new
      @state.switch_current_turn!
      @state.current_player.should eq(:black)
    end

    it "should change to white turn when signaled to switch" do
      @state = State.new
      @state.switch_current_turn!
      @state.switch_current_turn!

      @state.current_player.should eq(:white)
    end
  end

end
