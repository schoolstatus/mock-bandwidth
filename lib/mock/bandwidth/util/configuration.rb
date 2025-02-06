# frozen_string_literal: true

module Mock
  module Bandwidth
    module Util
      class Configuration
        attr_accessor :webhook_message_status_url, :disable_webhooks

        def webhook_message_status_url=(value)
          @webhook_message_status_url = value
        end

        def disable_webhooks=(value)
          @disable_webhooks = value
        end
      end
    end
  end
end
