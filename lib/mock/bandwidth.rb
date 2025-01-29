# frozen_string_literal: true

require "rufus-scheduler"
require "active_support"
require "active_support/core_ext/time"
require "httparty"
require_relative "bandwidth/version"
require_relative "bandwidth/middleware/proxy"
require_relative "bandwidth/response"
require_relative "bandwidth/decorator"
require_relative "bandwidth/webhook_client"
require_relative "bandwidth/webhooks/base"
require_relative "bandwidth/webhooks/messages"
require_relative "bandwidth/util/error_handler"
require_relative "bandwidth/util/configuration"

module Mock
  module Bandwidth
    extend SingleForwardable

    def_delegators :configuration, :webhook_message_status_url

    def self.configure(&block)
      yield configuration
    end

    def self.configuration
      @configuration ||= Util::Configuration.new
    end

    private_class_method :configuration
  end
end
