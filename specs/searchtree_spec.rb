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
    expect { SearchTree.new.minimax(nil, 0, 1) }.to raise_error
  end

=begin
  it 'should return a heuristic value for depth 0' do
    s = SearchTree.new
    s.minimax(s.generate, 0, 1).should be_a_kind_of Numeric
  end

  it 'should return a heuristic value' do
    s = SearchTree.new
    s.minimax(s.generate, 2, 1).should be_a_kind_of Numeric
  end
=end

  it 'should return a Move' do
    s = SearchTree.new
    res = s.search(s.generate)
    res.should be_an_instance_of Array
    p = Position.new
    p.new_game!
    p.move!(res)
    puts p.to_s
  end

  it "#get_color should only accept 1 or -1" do
    expect { SearchTree.new.get_color(-10) }.to raise_error
  end

end
