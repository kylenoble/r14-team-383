require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ReNBA
  class Application < Rails::Application

    config.autoload_paths << Rails.root.join('lib')

    config.encoding = "utf-8"
  end
end
