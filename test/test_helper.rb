# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  add_filter '/test/'
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "mock/bandwidth"
require "minitest/autorun"
require "bandwidth-sdk"
require "webmock/minitest"
require "timecop"
require "pry"

Bandwidth.configure do |config| # Configure Basic Auth
  config.username = "username"
  config.password = "password"
  config.configure_faraday_connection do |connection|
    connection.proxy = "http://mock-server.test"
    connection.use Mock::Bandwidth::Middleware::Proxy
  end
end

Mock::Bandwidth.configure do |config|
  config.webhook_message_status_url = "http://my-server.com/webhooks/bandwidth/messages_updates"
end
