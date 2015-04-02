require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*.rb']
  t.verbose = true
end

task :default do
  `rsdl ./lib/draw_ryan.rb`
end
