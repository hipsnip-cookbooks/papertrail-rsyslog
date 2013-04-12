require 'rake'
task :default => 'test'

desc "Run Strainer to create sandbox and test cookbook"
task :test do
  puts "=== Running Strainer... ==="
  sh "bundle exec strainer test"
end

desc "Run Strainer with fail-fast - for development"
task :dev_test do
  puts "=== Running Strainer... ==="
  sh "bundle exec strainer test --fail-fast"
end

desc "Run Strainer and then Test Kitchen - won't work on Travis"
task :full_test do
  Rake::Task["test"].invoke
  puts "=== Running Test Kitchen... ==="
  Rake::Task["kitchen:all"].invoke
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV['CI']
end
