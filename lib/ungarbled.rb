require 'active_support/core_ext/string/inflections'
require 'erb'

module Ungarbled
  class Encoder
    def initialize(browser, options = {})
      @browser = browser
      @options = options
      self.locale = options.delete(:locale) || 'base'
    end

    attr_accessor :locale

    def locale=(locale)
      @delegate = "::Ungarbled::Encoders::#{locale.classify}"
                  .constantize.send(:new, @browser, @options)
      @locale = locale
    rescue NameError
      raise NotImplementedError,
            "Encoder #{locale.classify} is not implemented"
    end

    def method_missing(name, *args)
      @delegate.send name, *args
    end
  end
  module Encoders
    class Base
      def initialize(browser, options)
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
    class Japanese < Base
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
          super
        end
      end
    end
  end
end
