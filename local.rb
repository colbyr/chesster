require './lib/chesster.rb'
require 'celluloid'

@team_1_secret = '32c68cae'
@team_2_secret = '1a77594c'

puts 'Welcome to...'

puts '   _____ _                   _            _                     _ '
puts '  / ____| |                 | |          | |                   | |'
puts ' | |    | |__   ___  ___ ___| |_ ___ _ __| |     ___   ___ __ _| |'
puts ' | |    | \'_ \ / _ \/ __/ __| __/ _ \ \'__| |    / _ \ / __/ _` | |'
puts ' | |____| | | |  __/\__ \__ \ ||  __/ |  | |___| (_) | (_| (_| | |'
puts '  \_____|_| |_|\___||___/___/\__\___|_|  |______\___/ \___\__,_|_|'
puts
puts

puts 'Go to http://www.bencarle.com/chess/startgame to start a game'
puts 'Then supply the information asked for below'

print 'Please enter your your game id: '
game_id = gets.chomp.to_i
puts

print 'Please enter your team number: '
my_team_id = gets.chomp.to_i
puts

print 'Please enter your team secret: '
my_secret = gets.chomp

print 'Please enter chessters team number: '
chesster_team_id = gets.chomp.to_i
puts

print 'What is chesters team secret?'
chesster_secret = gets.chomp

print 'Which color would you like to play as?'
my_color = gets.chomp.to_sym
puts

puts 'Please and thank you.'

chesster = Chesster.new(game_id, chesster_team_id, chesster_secret, my_color == :white ? :black : :white)
my_ponger = Ponger.new(game_id, my_team_id, my_secret)

puts 'The state currently is:'
puts chesster.state.current_position.to_s

puts 'Now watch the screen, only try to move when it is your turn'
while true
  move_string = gets.chomp
  my_ponger.pong(move_string)
end
