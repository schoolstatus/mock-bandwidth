# frozen_string_literal: true

module Mock
  module Bandwidth
    module Decorators
      module MessagingV2
        class MessageCreate
          class << self
            def decorate(body, request)
              data = JSON.parse request.request_body

              body["to"] = data["to"] if body["to"]
              body["from"] = data["from"] if body["from"]
              body["owner"] = data["from"] if body["owner"]
              body["text"] = data["text"] if body["text"]
              body["applicationId"] = data["applicationId"] if body["applicationId"]

              body["id"] = message_id(body) if body["id"]

              body.to_json
            end

            def message_id(body)
              timestamp = (Time.now.to_f * 1000).to_i.to_s[0..12]
              random_part = SecureRandom.alphanumeric(15).downcase
              id = "#{timestamp}#{random_part}"
              scheduler = Rufus::Scheduler.new
              scheduler.in '2s' do
                begin
                  Mock::Bandwidth::Webhooks::Messages.trigger(id, body)
                rescue  => e
                  puts e
                end
              end
              id
            end
          end
        end
      end
    end
  end
end

