# frozen_string_literal: true

require 'youhub/models/base'

module Youhub
  module Models
    # @private
    class Revocation < Base
      def initialize(options = {})
        @data = options[:data]
      end
    end
  end
end
