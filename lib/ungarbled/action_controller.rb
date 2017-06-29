require 'ungarbled/action_controller_ext'

module ActionController
  module DataStreaming
    class << self
      prepend Ungarbled::ActionControllerExt
    end
  end
end
