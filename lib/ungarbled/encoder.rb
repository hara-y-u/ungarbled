Dir[File.expand_path('../encoders', __FILE__) << '/*.rb'].each do |file|
  require file
end

module Ungarbled
  class Encoder
    require 'active_support/core_ext/string/inflections'

    def initialize(browser, options = {})
      @browser = browser
      @options = options
      self.language = options.delete(:language) || :base
    end

    attr_accessor :language, :delegate

    def language=(language)
      @delegate = "::Ungarbled::Encoders::#{language.to_s.classify}"
                  .constantize.send(:new, @browser, @options)
      @language = language.to_sym
    rescue NameError
      raise NotImplementedError,
            "Encoder #{language.to_s.classify} is not implemented"
    end

    def method_missing(name, *args)
      @delegate.send name, *args
    end
  end
end
