# -*- encoding: utf-8 -*-
require 'test_helper'

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rails/test_help'

Rails.backtrace_cleaner.remove_silencers!

# Capybara
require 'minitest/rails/capybara'

# Encoder for test
class Ungarbled::Encoder::NoEffect < Ungarbled::Encoder::Base
  def encode(filename); filename; end
  def encode_for_zip_item(filename); filename; end
end

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

class RailtieTest < Capybara::Rails::TestCase
  def test_included
    assert_includes(ActionController::Base.included_modules,
                    Ungarbled::ActionControllerExt)
  end

  def test_filename_without_encode
    visit download_with_encode_filename_path
    assert_includes page.response_headers['Content-Disposition'],
                    'filename="日本語ファイル名.txt"'
  end

  def test_default_lang_config
    Capybara.current_driver = :ie7
    visit download_without_lang_specified_path
    assert_includes page.response_headers['Content-Disposition'],
                    'filename="%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%90%8D.txt"'
  end

  def test_filename_with_encode
    Capybara.current_driver = :ie7
    visit download_with_encode_filename_path
    assert_includes page.response_headers['Content-Disposition'],
                    'filename="%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%90%8D.txt"'
  end

  def test_changing_lang
    Capybara.current_driver = :ie7
    visit download_with_changing_lang_path
    assert_includes page.response_headers['Content-Disposition'],
                    'filename="日本語ファイル名.txt"'
  end
end
