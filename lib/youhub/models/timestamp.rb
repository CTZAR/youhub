# frozen_string_literal: true

module Youhub
  module Models
    # @private
    # Extend Time to have .to_json return the format needed to submit
    # timestamp to YouTube API.
    # Only needed while we support ActiveSupport 3.
    class Timestamp < Time
      def as_json(_options = nil)
        utc.iso8601(3)
      end
    end
  end
end
