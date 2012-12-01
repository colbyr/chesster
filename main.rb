require 'models/bitboard.rb'
require 'models/position.rb'
require 'lib/pinger.rb'
require 'lib/ponger.rb'

=begin

 2 colors
 6 pieces
 8 coords
----------
16 things <= BOOM HEX

0 - 1|a
1 - 2|b
2 - 3|c
3 - 4|d
4 - 5|e
5 - 6|f
6 - 7|g
7 - 8|h


pinger = Pinger.new
ponger = Ponger.new

puts 'BOOM: '
puts pinger.ping
puts pinger.ping(TRUE)
=end

board = Position.new
board.new_game!
board.serialize
