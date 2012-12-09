jruby gen_moves_table.rb white >>moves/white.csv &
echo 'spawned white generator'
jruby gen_moves_table.rb black >>moves/black.csv &
echo 'spawned black generator'