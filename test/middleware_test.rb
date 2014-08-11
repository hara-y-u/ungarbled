require 'test_helper'
require 'dummy_rack'

class MiddlewareTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    Ungarbled::Middleware.new(DummyRackApp.new, lang: :japanese)
  end

  def test_encoding_filename
    get '/download_multibyte', {}, { 'HTTP_USER_AGENT' => 'MSIE' }
    assert_equal last_response.header['Content-Disposition'],
                 'attachment; filename="%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%90%8D.txt"'
  end

  def test_not_encoding_filename
    get '/download_multibyte'
    assert_equal last_response.header['Content-Disposition'],
                 'attachment; filename="日本語ファイル名.txt"'

    get '/download', {}, { 'HTTP_USER_AGENT' => 'MSIE' }
    assert_equal last_response.header['Content-Disposition'],
                 'attachment; filename="filename.txt"'
  end
end
