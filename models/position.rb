# A position contains all the pieces present on the board at a
# particular point in the game

require './models/piece.rb'

class Position
  attr_reader :white, :black

  HUMAN_BOARD = [[nil, nil, nil, nil, nil, nil, nil, nil],
                 [nil, nil, nil, nil, nil, nil, nil, nil],
                 [nil, nil, nil, nil, nil, nil, nil, nil],
                 [nil, nil, nil, nil, nil, nil, nil, nil],
                 [nil, nil, nil, nil, nil, nil, nil, nil],
                 [nil, nil, nil, nil, nil, nil, nil, nil],
                 [nil, nil, nil, nil, nil, nil, nil, nil],
                 [nil, nil, nil, nil, nil, nil, nil, nil],
  ]

  @@positions =
    {:a8 => 56, :b8 => 57, :c8 => 58, :d8 => 59, :e8 => 60, :f8 => 61, :g8 => 62, :h8 => 63, 
     :a7 => 48, :b7 => 49, :c7 => 50, :d7 => 51, :e7 => 52, :f7 => 53, :g7 => 54, :h7 => 55,
     :a6 => 40, :b6 => 41, :c6 => 42, :d6 => 43, :e6 => 44, :f6 => 45, :g6 => 46, :h6 => 47,
     :a5 => 32, :b5 => 33, :c5 => 34, :d5 => 35, :e5 => 36, :f5 => 37, :g5 => 38, :h5 => 39,
     :a4 => 24, :b4 => 25, :c4 => 26, :d4 => 27, :e4 => 28, :f4 => 29, :g4 => 30, :h4 => 31,
     :a3 => 16, :b3 => 17, :c3 => 18, :d3 => 19, :e3 => 20, :f3 => 21, :g3 => 22, :h3 => 23,
     :a2 =>  8, :b2 =>  9, :c2 => 10, :d2 => 11, :e2 => 12, :f2 => 13, :g2 => 14, :h2 => 15,
     :a1 =>  0, :b1 =>  1, :c1 =>  2, :d1 =>  3, :e1 =>  4, :f1 =>  5, :g1 =>  6, :h1 =>  7 }


  def valuate(color)
    pieces = color == :white ? @white : @black
    pieces[:pawn].length * 1 +
    pieces[:knight].length * 3 +
    pieces[:bishop].length * 3 +
    pieces[:rook].length * 5 +
    pieces[:queen].length * 9 +
    pieces[:king].length * 1_000_000
  end

  def empty_set
    set = {}
    set[:pawn] = Piece.new
    set[:rook] = Piece.new
    set[:knight] = Piece.new
    set[:bishop] = Piece.new
    set[:king] = Piece.new
    set[:queen] = Piece.new
    set
  end

  def initialize(white=empty_set, black=empty_set)
    @white = white
    @black = black
  end

  def new_game!
    @white[:pawn] = Piece.new([:a2, :b2, :c2, :d2, :e2, :f2, :g2, :h2])
    @white[:rook] = Piece.new([:a1, :h1])
    @white[:knight] = Piece.new([:b1, :g1])
    @white[:bishop] = Piece.new([:c1, :f1]) 
    @white[:king] = Piece.new([:e1])
    @white[:queen] = Piece.new([:d1])

    @black[:pawn] = Piece.new([:a7, :b7, :c7, :d7, :e7, :f7, :g7, :h7])
    @black[:rook] = Piece.new([:a8, :h8])
    @black[:knight] = Piece.new([:b8, :g8])
    @black[:bishop] = Piece.new([:c8, :f8])
    @black[:king] = Piece.new([:e8])
    @black[:queen] = Piece.new([:d8])
    self
  end

  def deep_copy
    Marshal.load(Marshal.dump(self))
  end

  def over?
    @black[:king].gone? || @white[:king].gone?
  end

  # Perform a move of format [:current_position_of_piece_to_move,
  # :position to move to]
  #
  # WARNING!! This method modifies state of current object AND returns
  # a copy of the newly modified object. TODO FIX
  #
  # TODO: Detect capture
  def move!(move)
    from = move[0]
    to = move[1]
    piece = self[from]

    #puts 'Moving piece from ' + from.to_s + ' to ' + to.to_s

    clear!(to)
    self[to] = piece
    self[from] = nil

    self
  end

  def move(move)
    deep_copy.move!(move)
  end

  def move_from_string(move_string)
    from = move_string[1..2].to_sym
    to = move_string[3..4].to_sym
    promotion = move_string[5]

    [from, to]
  end

  def string_from_move(move)
    piece = self[move[0]]
    p = ''

    case piece[1]
    when :pawn
      p = 'P'
    when :rook
      p = 'R'
    when :knight
      p = 'N'
    when :bishop
      p = 'B'
    when :king
      p = 'K'
    when :queen
      p = 'Q'
    end

    from = move[0].to_s
    to = move[1].to_s

    promotion = nil

    p.to_s + from.to_s + to.to_s + promotion.to_s
  end

  def [](square)
    if square == nil
      return nil
    else
      raise ArgumentError, "#{square} is not a valid square, :a1,...,:h8 expected" unless Square.include?(square)
      @white.each { |piece, position| return [:white, piece] if position.set?(square) }
      @black.each { |piece, position| return [:black, piece] if position.set?(square) }
      nil # Really weird fall-through...
    end
  end

  def set?(square)
    self[square]
  end

  def clear?(square)
    !self[square]
  end

  # Set square to be occupied by piece or nil to clear
  def []=(square, piece)
    raise ArgumentError unless Square.include?(square)

    return clear!(square) if piece.nil?

    raise ArgumentError unless Piece::Color.include?(piece[0])
    raise ArgumentError unless Piece::Type.include?(piece[1])

    if piece[0] == :white
      @white[piece[1]].set!(square)
    else
      @black[piece[1]].set!(square)
    end
    self[square]
  end

  def all_pieces
    self.white_pieces | self.black_pieces
  end

  def white_pieces
    all = Bitboard.new
    @white.each_value{|piece| all |= piece.bitboard }
    all
  end

  def black_pieces
    all = Bitboard.new
    @black.each_value{|piece| all |= piece.bitboard }
    all
  end

  def serialize
    str = ''
    @@positions.keys.each { |coord|
      p = self[coord]
      if !p.nil?
        coord = coord.to_s
        str << (p[0] == :black ? '1' : '2')
        str << @@lcoords.index(coord[0]).to_s
        str << (coord[1].to_i - 1).to_s
        str << @@pieceindex.index(p[1]).to_s
      end
    }
    str.to_i(8)
  end

  @@lcoords = ('a'..'h').to_a
  @@pieceindex = [:pawn, :knight, :bishop, :rook, :queen, :king]

  def self.unserialize(key)
    state = key.to_s(8)
    len = state.length
    pos = self.new
    i = 0
    while i < len do
      s = state[i, 4]
      p = []
      coord = (@@lcoords[s[1].to_i] + (s[2].to_i + 1).to_s).to_sym
      p[0] = s[0] == '1' ? :black : :white
      p[1] = @@pieceindex[s[3].to_i]
      pos[coord] = p
      i += 4
    end
    pos
  end

  def to_s
    count = 1
    subcount = 8
    human_board = [[nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
    ]

    output = "  a b c d e f g h\n"

    @@positions.each { |coordinate, value|
      p = self[coordinate]
      if p == nil
        piece = '_ '
      else
        color = p[0]
        piece = p[1]
      end

      if count % 8 == 1
        output += subcount.to_s + ' '
        subcount = subcount - 1
      end

      case piece
      when :pawn
        if color == :white
          output += [0x2659].pack('U*') + ' '
        else
          output += [0x265F].pack('U*') + ' '
        end
      when :rook
        if color == :white
          output += [0x2656].pack('U*') + ' '
        else
          output += [0x265C].pack('U*') + ' '
        end
      when :knight
        if color == :white
          output += [0x2658].pack('U*') + ' '
        else
          output += [0x265E].pack('U*') + ' '
        end
      when :bishop
        if color == :white
          output += [0x2657].pack('U*') + ' '
        else
          output += [0x265D].pack('U*') + ' '
        end
      when :king
        if color == :white
          output += [0x2654].pack('U*') + ' '
        else
          output += [0x265A].pack('U*') + ' '
        end
      when :queen
        if color == :white
          output += [0x2655].pack('U*') + ' '
        else
          output += [0x265B].pack('U*') + ' '
        end
      when '_ '
        output += '_ '
      else
        output += 'derp'
      end
      if count % 8 == 0
        output += "\n"
      end
      count = count + 1
    }
    output
  end

  private
  def clear!(square)
    piece = self[square]
    if !piece.nil?
      if piece[0] == :white
        @white[piece[1]].clear! square
      else
        @black[piece[1]].clear! square
      end
    end
    nil
  end

end
