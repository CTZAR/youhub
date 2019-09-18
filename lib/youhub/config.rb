# frozen_string_literal: true

require 'youhub/models/configuration'

module Youhub
  # Provides methods to read and write global configuration settings.
  #
  # A typical usage is to set the API keys retrieved from the
  # {http://console.developers.google.com Google Developers Console}.
  #
  # @example Set the API key for a server-only YouTube app:
  #   Youhub.configure do |config|
  #     config.api_key = 'ABCDEFGHIJ1234567890'
  #   end
  #
  # @example Set the API client id/secret for a web-client YouTube app:
  #   Youhub.configure do |config|
  #     config.client_id = 'ABCDEFGHIJ1234567890'
  #     config.client_secret = 'ABCDEFGHIJ1234567890'
  #   end
  #
  # Note that Youhub.configure has precedence over values through with
  # environment variables (see {Youhub::Models::Configuration}).
  #
  module Config
    # Yields the global configuration to the given block.
    #
    # @example
    #   Youhub.configure do |config|
    #     config.api_key = 'ABCDEFGHIJ1234567890'
    #   end
    #
    # @yield [Yt::Models::Configuration] The global configuration.
    def configure
      yield configuration if block_given?
    end

    # Returns the global {Youhub::Models::Configuration} object.
    #
    # While this method _can_ be used to read and write configuration settings,
    # it is easier to use {Youhub::Config#configure} Youhub.configure}.
    #
    # @example
    #     Youhub.configuration.api_key = 'ABCDEFGHIJ1234567890'
    #
    # @return [Youhub::Models::Configuration] The global configuration.
    def configuration
      @configuration ||= Youhub::Configuration.new
    end
  end

  # @note Config is the only module auto-loaded in the Youhub module,
  #       in order to have a syntax as easy as Youhub.configure

  extend Config
end
