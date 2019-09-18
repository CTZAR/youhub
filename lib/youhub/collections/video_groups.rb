# frozen_string_literal: true

require 'youhub/collections/base'
require 'youhub/models/video_group'
require 'youhub/models/group_info'

module Youhub
  module Collections
    # @private
    class VideoGroups < Base
      private

      def attributes_for_new_item(data)
        { id: data['id'], auth: @auth, group_info: Youhub::GroupInfo.new(data: data) }
      end

      def new_item(data)
        super if data['contentDetails']['itemType'] == 'youtube#video'
      end

      def list_params
        super.tap do |params|
          params[:host] = 'youtubeanalyouhubics.googleapis.com'
          params[:path] = '/v2/groups'
          params[:params] = @parent.video_groups_params
        end
      end
    end
  end
end
