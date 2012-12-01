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

end
