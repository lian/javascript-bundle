require 'rake'

desc 'run specs'
task(:spec) { sh 'ruby spec/*spec.rb' }
task :default => :spec

namespace :spec do
  desc 'run extjs specs'
  task(:extjs) { sh 'ruby spec/extjs_spec.rb' }
end
