module Ungarbled
  class Encoder
    require 'active_support/core_ext/string/inflections'

    def initialize(browser, options = {})
      @browser = browser
      @options = options
      self.language = options.delete(:language) || :base
    end

    attr_accessor :language

    def language=(language)
      @delegate = "::Ungarbled::Encoders::#{language.to_s.classify}"
                  .constantize.send(:new, @browser, @options)
      @language = language.to_sym
    rescue NameError
      raise NotImplementedError,
            "Encoder #{language.classify} is not implemented"
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
          super
        end
      end
    end
  end
end
