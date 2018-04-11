# -*- encoding: utf-8 -*-
require 'test_helper'
require 'browser'
require 'ungarbled/encoder/base'

class BaseTest < MiniTest::Test
  def setup
    @browser =
      if Browser.method(:new).parameters.flatten.count == 1
        ::Browser.new(ua: 'Safari')
      else
        ::Browser.new('Safari')
      end
  end

  def test_encode_method
    encoder = Ungarbled::Encoder::Base.new(@browser)
    assert_equal '日本語ファイル名.txt', encoder.encode('日本語ファイル名.txt')

    browser =
      if Browser.method(:new).parameters.flatten.count == 1
        ::Browser.new(ua: 'MSIE')
      else
        ::Browser.new('MSIE')
      end

    encoder = Ungarbled::Encoder::Base.new(browser)
    assert_equal '%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%90%8D.txt',
                 encoder.encode('日本語ファイル名.txt')
    assert_equal 'ascii_filename.txt', encoder.encode('ascii_filename.txt')
  end
end
