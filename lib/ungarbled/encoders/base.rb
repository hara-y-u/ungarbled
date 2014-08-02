module Ungarbled
  module Encoders
    class Base
      def initialize(browser, options = {})
        @browser = browser
        @options = options
      end

      def encode(filename)
        filename
      end

      def encode_for_zip_item(filename)
        filename
      end
    end
  end
end
