# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
require 'resque'
require 'resque/server'

run Resque::Server.new
run Rails.application
