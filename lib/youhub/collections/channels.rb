# frozen_string_literal: true

require 'youhub/collections/resources'

module Youhub
  module Collections
    # Provides methods to interact with a collection of YouTube channels.
    #
    # Resources with channels are: {Youhub::Models::Account accounts}.
    class Channels < Resources
      private

      def attributes_for_new_item(data)
        super(data).tap do |attributes|
          attributes[:statistics] = data['statistics']
        end
      end

      # @return [Hash] the parameters to submit to YouTube to list channels.
      # @see https://developers.google.com/youtube/v3/docs/channels/list
      def list_params
        super.tap { |params| params[:params] = channels_params }
      end

      def channels_params
        params = resources_params
        params.merge! mine: true if @parent
        apply_where_params! params
      end
    end
  end
end
