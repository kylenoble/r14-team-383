# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'resque'
require 'resque/tasks'
$stdout.sync = true

task :setup_resque do
  File.open("resque.pid", 'w') do |file|
    puts "PID: #{Process.pid}" if Rails.env == "development"
    file.puts Process.pid
  end
end

Rake::Task["resque:work"].enhance [:setup_resque]
Rails.application.load_tasks
