module Ungarbled
  class Encoder
    class Japanese < Base
      require 'erb'

      def encode(filename)
        if @browser.ie?
          ::ERB::Util.url_encode(filename)
        else
          super
        end
      end

      def encode_for_zip_item(filename)
        if @browser.windows? && !@browser.windows8?
          filename.encode('cp932', invalid: :replace)
        else
          supe
        end
      end
    end
  end
end
