# frozen_string_literal: true

module Mock
  module Bandwidth
    class ErrorHandler
      def initialize(response)
        @response = response
      end

      def raise
        @response.body
      end
    end
  end
end
