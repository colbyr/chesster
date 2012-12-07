class Bitboard
  MaxValue = 0xffffffffffffffff
  MinValue = 0x0

  attr_reader :value

  # shit bifting
  Mask = [1<< 0, 1<< 1, 1<< 2, 1<< 3, 1<< 4, 1<< 5, 1<< 6, 1<< 7,
          1<< 8, 1 <<9, 1<<10, 1<<11, 1<<12, 1<<13, 1<<14, 1<<15,
          1<<16, 1<<17, 1<<18, 1<<19, 1<<20, 1<<21, 1<<22, 1<<23,
          1<<24, 1<<25, 1<<26, 1<<27, 1<<28, 1<<29, 1<<30, 1<<31,
          1<<32, 1<<33, 1<<34, 1<<35, 1<<36, 1<<37, 1<<38, 1<<39,
          1<<40, 1<<41, 1<<42, 1<<43, 1<<44, 1<<45, 1<<46, 1<<47,
          1<<48, 1<<49, 1<<50, 1<<51, 1<<52, 1<<53, 1<<54, 1<<55,
          1<<56, 1<<57, 1<<58, 1<<59, 1<<60, 1<<61, 1<<62, 1<<63]

  def initialize(value=0)
    #raise ArgumentError, sprintf("%32x", value) + " passed\nis out of range." if value < MinValue || value > MaxValue
    @value=value
  end

  # Test equality
  def ==(other)
    self.equal?(other) || @value.equal?(other) || (other.class == Bitboard && @value == other.value )
  end

  # Bitwise and
  def &(other)
    other = other.value if other.class == Bitboard
    Bitboard.new(@value & other)
  end

  # Bitwise or
  def |(other)
    other = other.value if other.class == Bitboard
    Bitboard.new(@value | other)
  end

  # Birwise not
  def ~()
    #notvalue = Bitboard.new
    #0.upto(63){|i| notvalue.set!(i) if self.clear?(i)}
    #notvalue
    Bitboard.new(self.value ^ Bitboard::MaxValue)
  end

  # Bitwise xor
  def ^(other)
    other = other.value if other.class == Bitboard
    Bitboard.new(@value ^ other)
  end

  def set!(n)
    @value = @value | (Mask[n])
  end

  def clear!(n)
    @value &= (Mask[n]) ^ MaxValue
  end

  def set?(n)
    (@value & Mask[n]) == Mask[n]
  end

  def clear?(index)
    !set?(index)
  end

  def empty?
    self == 0
  end

  def value
    @value
  end

  # Array of bits that are set with index
  def set_bits
    bits = []
    0.upto(63) {|i| bits << i if set?(i)}
    bits
  end
end
