# frozen_string_literal: true

require 'youhub/errors/request_error'

module Youhub
  module Errors
    class NoItems < RequestError
      def explanation
        'A request to YouTube API returned no items but some were expected'
      end
    end
  end
end
