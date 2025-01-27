# frozen_string_literal: true

module Mock
  module Bandwidth
    class Response
      attr_accessor :body

      def self.call(body, request)
        body = '{}' if !body || body.empty?
        @body = Mock::Bandwidth::Decorator.call(body, request)
      end
    end
  end
end
