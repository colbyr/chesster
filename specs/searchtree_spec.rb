require 'searchtree'

describe SearchTree do

  it "should generate a position object" do
    @s = SearchTree.new
    response = @s.generate
    response.class.should eq(Position)
  end

  it "heuristic should return an integer" do
    s = SearchTree.new
    s.heuristic(s.generate).should be_a_kind_of Numeric
  end

  it 'should throw an NIL exception' do
    expect { SearchTree.new.minimax(nil, 0, true) }.to raise_error
  end

  it 'should return a heuristic-position tuple for depth 0' do
    s = SearchTree.new
    res = s.minimax(s.generate, 0, true)
    res.should be_a_kind_of Array
    res[0].should be_a_kind_of Numeric
    res[1].should be_an_instance_of Position
  end

  it 'should return a heuristic-position tuple' do
    s = SearchTree.new
    res = s.minimax(s.generate, 2, true)
    res.should be_a_kind_of Array
    res[0].should be_a_kind_of Numeric
    res[1].should be_an_instance_of Position
  end

  it 'should return a Position' do
    s = SearchTree.new
    res = s.search(s.generate)
    res.should be_an_instance_of Position
  end

end
