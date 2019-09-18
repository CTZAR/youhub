# frozen_string_literal: true

require 'youhub/models/base'

module Youhub
  module Models
    # @private
    # Encapsulates channel data that is relevant for YouTube Partners linked
    # with the channel.
    # @see https://developers.google.com/youtube/v3/docs/channels#contentOwnerDetails
    class ContentOwnerDetail < Base
      def initialize(options = {})
        @data = options[:data] || {}
      end

      has_attribute :content_owner
      has_attribute :time_linked, type: Time
    end
  end
end
