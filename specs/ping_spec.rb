require 'rspec'
require 'pinger'

describe Pinger do
  context 'pinging with no new move' do

    before(:each) do
      @pinger = mock(Pinger)
      @pinger.stub!(:ping).and_return({'ready' => false})
    end

    it "should check server for new move" do
      response = @pinger.ping
      response['ready'].should eq(false)
    end

  end

  context 'pinging with new move' do

    before(:each) do
      @pinger = mock(Pinger)
      @pinger.stub!(:ping).and_return({'ready' => true, 'lastmove' => 'Pe2e4', 'secondsleft' => 900})
    end

    it "should return new move from server" do
      response = @pinger.ping

      response['lastmove'].should match(/^[KQRBNP][a-h][1-8][a-h][1-8][QRBN]?/)
    end
  end
end


