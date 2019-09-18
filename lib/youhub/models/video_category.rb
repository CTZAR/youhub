# frozen_string_literal: true

require 'youhub/models/resource'

module Youhub
  module Models
    # @private
    # Provides methods to interact with YouTube video categories.
    # @see https://developers.google.com/youtube/v3/docs/videoCategories
    class VideoCategory < Resource
      delegate :data, :title, to: :snippet
    end
  end
end
