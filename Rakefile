# file: Rakefile
require 'rake/testtask'
 
Rake::TestTask.new do |task|
  task.libs << "./" 
  task.test_files = FileList['./test*.rb']
  task.warning = false 
  task.verbose = false # true prints load path to console
end
 
task :default => :test