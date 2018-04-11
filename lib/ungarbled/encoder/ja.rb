require_relative 'base'

module Ungarbled
  class Encoder
    class Ja < Base
      def encode_for_zip_item(filename)
        if @browser.respond_to?(:windows?)
          if @browser.windows? && !@browser.windows8?
            return filename.encode('cp932', invalid: :replace)
          end
        else
          if @browser.platform.windows? && !@browser.platform.windows8?
            return filename.encode('cp932', invalid: :replace)
          end
        end
        super
      end
    end
  end
end
