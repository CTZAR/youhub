# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/content_owner'

describe Youhub::Asset, :partner do
  describe '.ownership' do
    let(:asset) { Youhub::Asset.new id: asset_id, auth: $content_owner }
    describe 'given an asset administered by the content owner' do
      let(:asset_id) { ENV['YOUHUB_TEST_PARTNER_ASSET_ID'] }

      specify 'the ownership can be obtained' do
        expect(asset.ownership).to be_a Youhub::Ownership
      end

      describe 'the asset can be updated' do
        let(:attrs) { { metadata_mine: { notes: 'Youhub notes' } } }
        it { expect(asset.update(attrs)).to be true }
      end
    end
  end
end
