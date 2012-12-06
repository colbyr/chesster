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


  def initialize(white={}, black={})
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
    nil
  end

  def deep_copy
    Marshal.load(Marshal.dump(self))
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

    self[to] = piece
    self[from] = nil

    self
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

  def to_s
    count = 1
    human_board = [[nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
    ]

    output = ''

    @@positions.each { |coordinate, value|
      p = self[coordinate]
      if p == nil
        piece = '_ '
      else
        color = p[0]
        piece = p[1]
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
      output += "\n" if count % 8 == 0
      count = count +1
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
