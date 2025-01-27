# frozen_string_literal: true

require_relative "bandwidth/version"
require_relative "bandwidth/middleware/proxy"
require_relative "bandwidth/response"
require_relative "bandwidth/decorator"

module Mock
  module Bandwidth
    class Error < StandardError; end
  end
end
