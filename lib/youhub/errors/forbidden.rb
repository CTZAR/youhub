# frozen_string_literal: true

require 'youhub/errors/request_error'

module Youhub
  module Errors
    class Forbidden < RequestError
      def explanation
        'A request to YouTube API was considered forbidden by the server'
      end
    end
  end
end
