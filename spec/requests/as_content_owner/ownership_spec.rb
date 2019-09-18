# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/ownership'

describe Youhub::Ownership, :partner do
  subject(:ownership) { Youhub::Ownership.new asset_id: asset_id, auth: $content_owner }

  context 'given an asset managed by the authenticated Content Owner' do
    let(:asset_id) { ENV['YOUHUB_TEST_PARTNER_ASSET_ID'] }

    describe 'the ownership can be updated' do
      let(:general_owner) { { ratio: 100, owner: 'FullScreen', type: 'include', territories: %w[US CA] } }
      it { expect(ownership.update(general: [general_owner])).to be true }
    end

    describe 'the complete ownership can be obtained' do
      before { ownership.release! }
      it { expect(ownership.obtain!).to be true }
    end

    describe 'the complete ownership can be released' do
      after { ownership.obtain! }
      it { expect(ownership.release!).to be true }
    end
  end
end
