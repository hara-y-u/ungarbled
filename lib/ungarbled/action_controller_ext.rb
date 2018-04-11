require 'action_controller/railtie'
require 'browser/rails'
require 'ungarbled/encoder'

module Ungarbled
  module ActionControllerExt
    extend ActiveSupport::Concern

    SEND_FILE_HEADERS_PROC = lambda do |options|
      if !::Rails.configuration.ungarbled.disable_auto_encode &&
         options[:filename]
        options[:filename] = encode_filename(options[:filename])
      end

      if defined?(send_file_headers_without_encode_filename!)
        send_file_headers_without_encode_filename!(options)
      else
        super
      end
    end

    included do
      helper_method :encode_filename
      helper_method :encode_filename_for_zip_item
      define_method :send_file_headers_with_encode_filename!, &SEND_FILE_HEADERS_PROC
      alias_method_chain :send_file_headers!, :encode_filename
    end

    def self.prepended(mod)
      class << mod
        define_method :send_file_headers!, &SEND_FILE_HEADERS_PROC
      end
      mod.helper_method :encode_filename
      mod.helper_method :encode_filename_for_zip_item
    end

    private

    def filename_encoder(options)
      @filename_encoder ||= Ungarbled::Encoder.new(browser)
      lang = options[:lang] ||
             Rails.configuration.ungarbled.default_lang
      @filename_encoder.tap { |e| e.lang = lang }
    end

    def encode_filename(filename, options = {})
      filename_encoder(options).encode(filename)
    end

    def encode_filename_for_zip_item(filename, options = {})
      filename_encoder(options).encode_for_zip_item(filename)
    end
  end
end
