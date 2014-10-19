#ruby=ruby-2.2.0-preview1
source 'https://rubygems.org'
ruby "2.2.0"
gem 'rails', '4.2.0.beta2'
gem 'sass-rails', '~> 5.0.0.beta1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'addressable'
gem 'turbolinks'
gem "algoliasearch-rails"
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'bootstrap-sass'
gem 'bootstrap-slider-rails'
gem "resque", "~> 1.25.2", :require => "resque/server"
gem 'redis'
gem 'hiredis'
gem 'rake'
gem 'nokogiri'
gem 'mechanize'
group :therubyracer do
  gem 'therubyracer', :platform=>:ruby
end
gem 'arel-helpers'
group :development, :test do
  gem 'pry'
  gem 'railroady'
end
group :development do
  gem 'better_errors'
  gem 'sqlite3'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'annotate', '~> 2.6.5'
end
group :production do
  gem 'heroku-api'
  gem 'pg'
  gem 'rails_12factor'
  gem 'rails_log_stdout',	github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
  gem 'unicorn'
end
