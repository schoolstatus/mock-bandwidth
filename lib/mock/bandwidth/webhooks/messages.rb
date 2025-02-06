# frozen_string_literal: true

module Mock
  module Bandwidth
    module Webhooks
      class Messages < Base
        def self.trigger(id, body)
          return if Mock::Bandwidth.disable_webhooks

          # Wait simulation from twilio
          sleep DELAY.sample

          url = Mock::Bandwidth.webhook_message_status_url

          params = {
            _json: [
              {
                time: Time.current.rfc2822,
                type: "message-delivered",
                to: body["to"],
                description: "Message delivered to carrier.",
                message: {
                  id: id,
                  owner: body["from"],
                  applicationId: "12341234",
                  time: Time.current.rfc2822,
                  segmentCount: 1,
                  direction: "out",
                  to: [
                    body["to"]
                  ],
                  from: body["from"],
                  text: body["text"],
                  tag: "",
                },
              }
            ],
          }.to_json

          response = webhook_client.new(url: url, params: params, headers: headers).post

          case response.code.to_i
          when 200..204
            response
          when 400..600
            raise Webhooks::RestError, Mock::Bandwidth::ErrorHandler.new(response).raise
          end
        end
      end
    end
  end
end
