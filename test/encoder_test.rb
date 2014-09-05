require 'test_helper'
require 'browser'
require 'ungarbled/encoder'

class EncoderTest < MiniTest::Test
  def setup
    @browser = Browser.new(ua: 'Safari')
  end

  def test_initialize_method
    encoder = Ungarbled::Encoder.new(@browser)
    assert_respond_to encoder, :lang
    assert_respond_to encoder, :lang=
    assert_respond_to encoder, :delegate
    assert_kind_of Ungarbled::Encoder::Base, encoder.delegate
  end

  def test_initialize_method_fails_with_unimplemented_lang
    assert_raises NotImplementedError do
      Ungarbled::Encoder.new(@browser, lang: 'unexistlang')
    end
  end

  def test_set_lang
    encoder = Ungarbled::Encoder.new(@browser, lang: 'ja')
    assert_kind_of Ungarbled::Encoder::Ja, encoder.delegate
    encoder.lang = 'base'
    assert_kind_of Ungarbled::Encoder::Base, encoder.delegate
  end
end
