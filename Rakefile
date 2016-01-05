require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'coveralls/rake/task'
require 'cucumber/rake/task'

Coveralls::RakeTask.new
RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new

#task :default => [:spec, :cucumber, 'coveralls:push']
task :default => [:spec, 'coveralls:push']
