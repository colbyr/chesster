require './lib/searchtree.rb'

s = SearchTree.new

game = s.generate
turn = true

def get_move
end

while !game.over? do

  if turn
    puts 'Chesster\'s move...'
    move = s.search(game, 2)
  else
    print 'your move: '
    raw = gets.chomp
    move = game.move_from_string raw
    puts
  end

  game.move!(move)
  turn = !turn
  puts game.to_s

end

puts
puts 'GAME OVER'
puts
puts game.to_s
