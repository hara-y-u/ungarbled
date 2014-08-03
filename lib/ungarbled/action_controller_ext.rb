require 'action_controller/railtie'
require 'browser/rails'
require 'ungarbled/encoder'

module Ungarbled
  module ActionControllerExt
    extend ActiveSupport::Concern

    included do
      helper_method :encode_filename
      helper_method :encode_filename_for_zip_item
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
