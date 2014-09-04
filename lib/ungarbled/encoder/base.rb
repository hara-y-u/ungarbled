module Ungarbled
  class Encoder
    class Base
      require 'erb'

      def initialize(browser, options = {})
        @browser = browser
        @options = options
      end

      def encode(filename)
        @browser.ie? ? ::ERB::Util.url_encode(filename) : filename
      end

      def encode_for_zip_item(filename)
        filename
      end
    end
  end
end
