require './lib/precalc.rb'

p = Precalc.new(:white, 6)
p.gen_moves(1_000_000)