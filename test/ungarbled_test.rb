require 'test_helper'
require 'browser'

class TestEncoder < MiniTest::Unit::TestCase
  def setup
    @browser = Browser.new(ua: 'Safari')
  end

  def test_initialize_method_successes
    encoder = Ungarbled::Encoder.new(@browser, locale: :japanese)
    assert_respond_to encoder, :method_missing
  end

  def test_initialize_method_fails_with_unimplemented_locale
    assert_raises NotImplementedError do
      Ungarbled::Encoder.new(@browser, locale: 'unexistlocale')
    end
  end

  def test_encode_method
    encoder = Ungarbled::Encoder.new(@browser, locale: 'japanese')
    assert_equal '日本語ファイル名', encoder.encode('日本語ファイル名')

    browser = Browser.new(ua: 'MSIE')

    encoder = Ungarbled::Encoder.new(browser, locale: 'japanese')
    assert_equal '%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%90%8D',
                 encoder.encode('日本語ファイル名')
  end

  def test_encode_for_zip_item_method
    browser = Browser.new(ua: 'Windows')
    encoder = Ungarbled::Encoder.new(browser, locale: 'japanese')
    assert_equal 'Windows-31J',
                 encoder.encode_for_zip_item('日本語ファイル名').encoding.to_s
  end

  def test_set_locale
    browser = Browser.new(ua: 'MSIE')
    encoder = Ungarbled::Encoder.new(browser, locale: 'japanese')
    assert_equal '%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%90%8D',
                 encoder.encode('日本語ファイル名')
    encoder.locale = 'base'
    assert_equal '日本語ファイル名',
                 encoder.encode('日本語ファイル名')
  end
end
