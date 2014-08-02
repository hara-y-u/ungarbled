require 'test_helper'

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

  def test_filename_with_encode
    Capybara.current_driver = :ie7
    visit download_with_encode_filename_path
    assert_includes page.response_headers['Content-Disposition'],
                    'filename="%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%90%8D.txt"'
  end

  def test_changing_language
    Capybara.current_driver = :ie7
    visit download_with_encode_filename_path
    assert_includes page.response_headers['Content-Disposition'],
                    'filename="%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%90%8D.txt"'
    visit download_path
    assert_includes page.response_headers['Content-Disposition'],
                    'filename="日本語ファイル名.txt"'
  end
end
