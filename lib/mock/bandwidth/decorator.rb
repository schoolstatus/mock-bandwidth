# frozen_string_literal: true

require_relative "schemas/messaging_v2"

module Mock
  module Bandwidth
    class Decorator
      ENDPOINTS = {
        messaging_v2: Mock::Bandwidth::Schemas::MessagingV2
      }

      class << self
        def call(body, request)
          body = JSON.parse(body)

          case request.status
          when 400..600
            return body
          end

          schema = url_from(body, request)
          # return body decorate if needed
          return ENDPOINTS[schema].for(body, request) if schema

          body
        end

        def url_from(body, request)
          url = request.url.path

          case url
          when %r{\/api\/v2\/users\/\d+\/messages}
            :messaging_v2
          end
        end
      end
    end
  end
end
