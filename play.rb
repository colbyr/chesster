require './lib/searchtree.rb'

color = ''
while (color != 'white' && color != 'black')
  print 'pick your color: '
  color = gets.chomp
end

chester_color = (color == 'white') ? :black : :white
puts 'Chesster is ' + chester_color.to_s
puts 'You are ' + color

s = SearchTree.new(chester_color)

game = s.generate
turn = chester_color == :white

puts game.to_s

while !game.over? do

  if turn
    puts 'Chesster\'s move...'
    puts
    move = s.search(game, 4)
  else
    print 'your move: '
    raw = gets.chomp
    move = game.move_from_string 'm' + raw
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
