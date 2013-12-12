require 'attune/param_flattener'

module Attune
  # Default options
  module Default
    extend Configurable

    ENDPOINT = "http://localhost/".freeze

    MIDDLEWARE = Faraday::Builder.new do |builder|
      # Needed for encoding of BATCH GET requests
      builder.use ParamFlattener

      # Allow one retry per request
      builder.request :retry, 1

      # Log all requests
      builder.response :logger

      # Raise exceptions for HTTP 4xx/5xx
      builder.response :raise_error
      builder.adapter Faraday.default_adapter
    end

    configure do |c|
      c.endpoint = ENDPOINT
      c.middleware = MIDDLEWARE
      c.disabled = false
      c.timeout = 1
    end
  end
end
