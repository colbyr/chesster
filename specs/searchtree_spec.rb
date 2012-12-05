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

end
