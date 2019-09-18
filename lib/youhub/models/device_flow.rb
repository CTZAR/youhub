# frozen_string_literal: true

require 'youhub/models/base'

module Youhub
  module Models
    # @private
    class DeviceFlow < Base
      def initialize(options = {})
        @data = options[:data]
      end

      has_attribute :device_code, camelize: false
      has_attribute :user_code, camelize: false
      has_attribute :verification_url, camelize: false
    end
  end
end
