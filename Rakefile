require 'rake/testtask'

task :test => ['test:core']

Rake::TestTask.new('test:core') do |test|
  test.libs    << 'lib' << 'test'
  test.pattern =  'test/core/*_test.rb'
  test.warning =  true
end
