task :default => 'testall'

desc "Run all tests in test directory"
task :testall do
  top_level_test_files.each {|file| sh "ruby test/#{file}"}
end

def top_level_test_files
  Dir.entries("test").select {|entry| entry.match /\w*_test.rb/}  
end