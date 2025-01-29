# frozen_string_literal: true

module Mock
  module Bandwidth
    module Webhooks
      class RestError < StandardError
      end
      class Base
        DELAY = [0.5, 0.8]

        def self.webhook_client
          Mock::Bandwidth::WebhookClient
        end

        def self.headers
          { "Content-Type" => "application/json" }
        end
      end
    end
  end
end
