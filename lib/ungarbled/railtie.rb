require 'rails/railtie'
require 'ungarbled/action_controller_ext'

module Ungarbled
  class Railtie < Rails::Railtie
    config.ungarbled = ActiveSupport::OrderedOptions.new

    # Now only Japanese is supported
    config.ungarbled.default_lang = :ja

    initializer 'ungarbled' do
      if defined?(Module.prepend)
        ::ActionController::Base.send :prepend, Ungarbled::ActionControllerExt
      else
        ::ActionController::Base.send :include, Ungarbled::ActionControllerExt
      end
    end
  end
end
