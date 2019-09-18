# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/advertising_options_set'

describe Youhub::AdvertisingOptionsSet, :partner do
  subject(:advertising_options_set) { Youhub::AdvertisingOptionsSet.new video_id: video_id, auth: $content_owner }

  context 'given a video managed by the authenticated Content Owner' do
    let(:video_id) { ENV['YOUHUB_TEST_PARTNER_CLAIMABLE_VIDEO_ID'] }

    describe 'the advertising options can be updated' do
      let(:params) { { ad_formats: %w[standard_instream long] } }
      it { expect(advertising_options_set.update(params)).to be true }
    end
  end
end
