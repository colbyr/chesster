require './models/bitboard.rb'

describe Bitboard do
  it "should initialize with a value of 0" do
    b = Bitboard.new
    b.value.should eq(0)
  end
end
