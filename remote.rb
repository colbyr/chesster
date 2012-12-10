require './lib/chesster.rb'
require 'celluloid'

puts 'Welcome to...'

puts '   _____ _                   _            '
puts '  / ____| |                 | |           '
puts ' | |    | |__   ___  ___ ___| |_ ___ _ __ '
puts ' | |    | \'_ \ / _ \/ __/ __| __/ _ \ \'__|'
puts ' | |____| | | |  __/\__ \__ \ ||  __/ |   '
puts '  \_____|_| |_|\___||___/___/\__\___|_|   '
puts
puts

puts 'Go to http://www.bencarle.com/chess/startgame to start a game'
puts 'Then supply the information asked for below'

print 'Please enter the game id: '
game_id = gets.chomp.to_i
puts

print 'Please enter chessters team number: '
chesster_team_id = gets.chomp.to_i
puts

print 'What is chesters team secret?'
chesster_secret = gets.chomp

print 'Whats your color?'
my_color = gets.chomp.to_sym
puts

puts 'Please and thank you.'

chesster = Chesster.new(game_id, chesster_team_id, chesster_secret, my_color)

puts 'The state currently is:'
puts chesster.state.current_position.to_s
