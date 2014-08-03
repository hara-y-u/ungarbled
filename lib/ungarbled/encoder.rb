Dir[File.expand_path('../encoder', __FILE__) << '/*.rb'].each do |file|
  require file
end

module Ungarbled
  class Encoder
    require 'active_support/core_ext/string/inflections'

    def initialize(browser, options = {})
      @browser = browser
      @options = options
      self.lang = options.delete(:lang) || :base
    end

    attr_accessor :lang, :delegate

    def lang=(lang)
      @delegate = "::Ungarbled::Encoder::#{lang.to_s.classify}"
                  .constantize.send(:new, @browser, @options)
      @lang = lang.to_sym
    rescue NameError
      raise NotImplementedError,
            "Encoder #{lang.to_s.classify} is not implemented"
    end

    def method_missing(name, *args)
      @delegate.send name, *args
    end
  end
end
