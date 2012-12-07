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

print 'Please enter your your game id: '
game_id = gets.chomp.to_i
puts

print 'Please enter which player you would like to play as (1, 2): '
my_team_id = gets.chomp.to_i
puts

print 'Please enter which player chesster should play as (1, 2): '
chesster_team_id = gets.chomp.to_i
puts

puts 'Please and thank you.'

chesster = Chesster.new(game_id, chesster_team_id, (chesster_team_id == 1 ? @team_1_secret : @team_2_secret))
my_ponger = Ponger.new(game_id, my_team_id, (my_team_id == 1 ? @team_1_secret : @team_2_secret))
#chesster = Chesster.new(28, 1, '32c68cae')

puts 'The state currently is:'
puts chesster.state.current_position.to_s

puts 'Now watch the screen, only try to move when it is your turn'
while true
  move_string = gets.chomp
  my_ponger.pong(move_string)
end
