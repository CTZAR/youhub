# frozen_string_literal: true

require 'youhub/collections/base'
require 'youhub/models/status'

module Youhub
  module Collections
    # @private
    class Statuses < Base
      private

      def attributes_for_new_item(data)
        { data: data['status'] }
      end

      # @return [Hash] the parameters to submit to YouTube to get the status
      #   of a resource, for instance a channel.
      # @see https://developers.google.com/youtube/v3/docs/channels/list
      def list_params
        endpoint = @parent.kind.pluralize.camelize :lower
        super.tap do |params|
          params[:path] = "/youtube/v3/#{endpoint}"
          params[:params] = { id: @parent.id, part: 'status' }
        end
      end
    end
  end
end
