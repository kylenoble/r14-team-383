require 'resque'
require 'resque/server'
if Rails.application.config.respond_to? :redis_address
  Resque.redis = Rails.application.config.redis_address
end