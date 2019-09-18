# frozen_string_literal: true

require 'youhub/version'
require 'youhub/constants/geography'
require 'youhub/models/account'
require 'youhub/models/channel'
require 'youhub/models/claim'
require 'youhub/models/claim_history'
require 'youhub/models/content_owner'
require 'youhub/models/match_policy'
require 'youhub/models/playlist'
require 'youhub/models/playlist_item'
require 'youhub/models/video'
require 'youhub/models/video_group'
require 'youhub/models/comment_thread'
require 'youhub/models/ownership'
require 'youhub/models/advertising_options_set'
require 'youhub/models/url'

# An object-oriented Ruby client for YouTube.
# Helps creating applications that need to interact with YouTube objects.
# Inclused methods to access YouTube Data API V3 resources (channels, videos,
# ...), YouTube Analytics API V2 resources (metrics, estimated_revenue, ...),
#  and objects not available through the API (annotations).
module Youhub
end
