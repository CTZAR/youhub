# frozen_string_literal: true

require 'youhub/collections/base'
require 'youhub/models/snippet'

module Youhub
  module Collections
    # @private
    class GroupInfos < Base
      private

      def attributes_for_new_item(data)
        { data: data, auth: @auth }
      end

      def list_params
        super.tap do |params|
          params[:host] = 'youtubeanalyouhubics.googleapis.com'
          params[:path] = '/v2/groups'
          params[:params] = { id: @parent.id }
          params[:params][:on_behalf_of_content_owner] = @auth.owner_name if @auth.owner_name
        end
      end
    end
  end
end
