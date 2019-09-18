# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/live_streaming_detail'

describe Youhub::LiveStreamingDetail do
  subject(:live_streaming_detail) { Youhub::LiveStreamingDetail.new data: data }
end
