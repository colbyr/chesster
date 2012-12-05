require 'searchtree'

describe SearchTree do

  it "should generate a position object" do
    @s = SearchTree.new
    response = @s.generate
    response.class.should eq(Position)
  end

  it "should return a random integer" do
    @s = SearchTree.new
    heuristic = @s.heuristic
    heuristic.class.should eq Fixnum
  end

  it 'should throw an NIL exception' do
    @s = SearchTree.new
    expect { @s.minimax(nil, 0, true) }.to raise_error
  end

end
