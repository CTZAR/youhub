# frozen_string_literal: true

require 'youhub/errors/request_error'

module Youhub
  module Errors
    class ServerError < RequestError
      def explanation
        'A request to YouTube API caused an unexpected server error'
      end
    end
  end
end
