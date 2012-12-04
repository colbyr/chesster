require 'searchtree'

describe SearchTree do
  it "should generate a position object" do
    @s = SearchTree.new
    response = @s.generate
    response.class.should eq(Position)
  end
end
