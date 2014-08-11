module Ungarbled
  class Middleware
    DISPOSITION_KEY = 'Content-Disposition'
    DISPOSITION_REGEX = /^(?:attachment|inline); filename="(.+)"$/

    def initialize(app, options = {})
      @app = app
      @options = options
    end

    def call(env)
      req = Rack::Request.new(env)
      browser = Browser.new(
        ua: req.user_agent,
        accept_language: req.env['HTTP_ACCEPT_LANGUAGE']
      )
      encoder = Ungarbled::Encoder.new(browser, @options)
      status, headers, res = @app.call(env)
      disposition = headers[DISPOSITION_KEY]

      if disposition
        headers[DISPOSITION_KEY] =
          encode_disposition(encoder, disposition)
      end

      [status, headers, res]
    end

    def encode_disposition(encoder, disposition)
      replacing = DISPOSITION_REGEX.match(disposition)[1]
      replaced = encoder.encode(replacing)
      disposition.gsub(replacing, replaced)
    end
  end
end
