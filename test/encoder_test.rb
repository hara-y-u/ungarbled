require 'test_helper'
require 'browser'

class EncoderTest < MiniTest::Test
  def setup
    @browser = Browser.new(ua: 'Safari')
  end

  def test_initialize_method
    encoder = Ungarbled::Encoder.new(@browser, language: :japanese)
    assert_respond_to encoder, :language
    assert_respond_to encoder, :language=
    assert_respond_to encoder, :delegate
    assert_kind_of Ungarbled::Encoder::Japanese, encoder.delegate
  end

  def test_initialize_method_fails_with_unimplemented_language
    assert_raises NotImplementedError do
      Ungarbled::Encoder.new(@browser, language: 'unexistlanguage')
    end
  end

  def test_set_language
    encoder = Ungarbled::Encoder.new(@browser, language: 'japanese')
    assert_kind_of Ungarbled::Encoder::Japanese, encoder.delegate
    encoder.language = 'base'
    assert_kind_of Ungarbled::Encoder::Base, encoder.delegate
  end
end
