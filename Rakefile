task :default => [:test]

task :test do
  ruby './tests/run.rb'
  sh 'bundle exec rspec specs'
end
