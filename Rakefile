require 'rake'

desc 'run specs'
task(:spec) { sh 'ruby spec/*spec.rb' }
task :default => :spec

namespace :spec do
  desc 'run all specs'
  task :all => [:bundle, :extjs]
  
  desc 'run extjs specs'
  task(:extjs) { sh 'ruby spec/extjs_spec.rb' }
  
  desc 'run bundle specs'
  task(:bundle) { sh 'ruby spec/bundle_spec.rb' }
end

