# frozen_string_literal: true

require_relative "../decorators/messaging_v2/message_create"

module Mock
  module Bandwidth
    module Schemas
      class MessagingV2
        class << self
          RESOURCES = {
            create_message: Mock::Bandwidth::Decorators::MessagingV2::MessageCreate,
          }
          def for(body, request)
            url = request.url.path

            case url
            when %r{\/api\/v2\/users\/\d+\/messages}
              return RESOURCES[:create_message].decorate(body, request) if request.method == :post
            end
          end
        end
      end
    end
  end
end
