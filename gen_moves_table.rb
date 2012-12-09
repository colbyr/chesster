require './lib/precalc.rb'

case ARGV[0]
when 'white'
  color = :white
when 'black'
  color = :black
else
  raise 'SON OF A BITCH'
end

p = Precalc.new(color, 2)
p.gen_moves()