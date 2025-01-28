# frozen_string_literal: true

module Mock
  module Bandwidth
    module Util
      class Configuration
        attr_accessor :webhook_message_status_url

        def webhook_message_status_url=(value)
          @webhook_message_status_url = value
        end
      end
    end
  end
end
