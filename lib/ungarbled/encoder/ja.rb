require_relative 'base'

module Ungarbled
  class Encoder
    class Ja < Base
      def encode_for_zip_item(filename)
        if @browser.platform.windows? && !@browser.platform.windows8?
          filename.encode('cp932', invalid: :replace)
        else
          super
        end
      end
    end
  end
end
