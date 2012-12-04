require './lib/api.rb'

describe API do
 context 'it is not our turn' do
   before(:each) do
    @api = mock(API)
    @api.stub!(:poll).and_return({'ready' => false, 'secondsleft' => 123.45, 'lastmovenumber' => 2})
    @api.stub!(:move).and_return({'message' => '', 'result' => true})
   end

   it "should poll the server for a new move" do
     response = @api.poll 
     response['ready'].should eq(false)
   end 

   it "should be able to inform the server of a move" do
     @response = @api.move(11,1,"32c68cae","Nb1c3")
     @response['result'].should eq(true)
   end
 end

 context 'it is our turn' do
   before(:each) do
    @api = mock(API)
    @api.stub!(:poll).and_return({'ready' => true, 'secondsleft' => 123.45, 'lastmovenumber' => 3, 'lastmove' => 'Pd2d3'})
   end

   it "should poll the server for seconds left" do
     response = @api.poll
     response['secondsleft'].should eq(123.45)
   end

   it "should return new move from server" do
     response = @api.poll
     response['lastmove'].should match(/^[KQRBNP][a-h][1-8][a-h][1-8][QRBN]?/)
   end
 end
end
