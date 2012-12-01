describe Pinger do
  it "should check server for new move" do
    Pinger.new
    response = Pinger.ping

    response.should match(/^[KQRBNP][a-h][1-8][a-h][1-8][QRBN]?/)
  end
end 


