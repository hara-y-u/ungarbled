# -*- encoding: utf-8 -*-
require 'test_helper'
require 'browser'
require 'ungarbled/encoder/ja'

class JaTest < MiniTest::Test
  def setup
    @browser =
      if Browser.method(:new).parameters.flatten.count == 1
        ::Browser.new(ua: 'Safari')
      else
        ::Browser.new('Safari')
      end
  end

  def test_encode_for_zip_item_method
    browser =
      if Browser.method(:new).parameters.flatten.count == 1
        ::Browser.new(ua: 'Windows')
      else
        ::Browser.new('Windows')
      end
    encoder = Ungarbled::Encoder::Ja.new(browser)
    assert_equal 'Windows-31J',
                 encoder.encode_for_zip_item('日本語ファイル名.txt').encoding.to_s
  end
end
