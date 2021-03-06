require 'searchtree'

describe SearchTree do

  it "should generate a position object" do
    @s = SearchTree.new
    response = @s.generate
    response.class.should eq(Position)
  end

  it "heuristic should return an integer" do
    s = SearchTree.new
    s.heuristic(s.generate, 1).should be_a_kind_of Numeric
  end

  it 'should throw an NIL exception' do
    expect { SearchTree.new.minimax(nil, 0, 1) }.to raise_error
  end

  it 'should return a heuristic value for depth 0' do
    s = SearchTree.new
    s.minimax(s.generate, 0, -Float::INFINITY, Float::INFINITY, 1).should be_a_kind_of Numeric
  end

  it 'should return a heuristic value' do
    s = SearchTree.new
    s.minimax(s.generate, 2, -Float::INFINITY, Float::INFINITY, 1).should be_a_kind_of Numeric
  end

  it 'should return a Move' do
    s = SearchTree.new
    res = s.search(s.generate, 2)
    res.should be_an_instance_of Array
  end

  it "#get_color should only accept 1 or -1" do
    expect { SearchTree.new.get_color(-10) }.to raise_error
  end

end
