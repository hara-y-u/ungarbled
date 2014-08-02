# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rails/test_help'

Rails.backtrace_cleaner.remove_silencers!

# Minitest
require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/rails/capybara'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
