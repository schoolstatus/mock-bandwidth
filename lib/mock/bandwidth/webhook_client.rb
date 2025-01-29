# frozen_string_literal: true

module Mock
  module Bandwidth
    class WebhookClient
      attr_reader :url, :params, :headers

      def initialize(url:, params: nil, headers: {})
        @url = url
        @params = params
        @headers = headers
      end

      def post
        arguments = { body: params, headers: headers }

        ::HTTParty.post(url, **arguments)
      end
    end
  end
end
