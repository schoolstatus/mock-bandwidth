# frozen_string_literal: true

require 'faraday'

module Mock
  module Bandwidth
    module Middleware
      class Proxy < Faraday::Middleware
        def initialize(app)
          super(app)
        end

        def call(env)
          env.url.host = env.request.proxy.host
          env.url.port = env.request.proxy.port
          env.url.scheme = env.request.proxy.scheme

          @app.call(env).on_complete do |request|
            if request.response_body
              request.body = Mock::Bandwidth::Response.call(request.response.body, request)
            end
          end
        end
      end
    end
  end
end

Faraday::Request.register_middleware(proxy: Mock::Bandwidth::Middleware::Proxy)
