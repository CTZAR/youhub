# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/playlist_item'

describe Youhub::PlaylistItem, :server_app do
  subject(:item) { Youhub::PlaylistItem.new id: id }

  context 'given an existing playlist item' do
    let(:id) { 'UExTV1lrWXpPclBNVDlwSkc1U3Q1RzBXRGFsaFJ6R2tVNC4yQUE2Q0JEMTk4NTM3RTZC' }

    it 'returns valid snippet data' do
      expect(item.snippet).to be_a Youhub::Snippet
      expect(item.title).to be_a String
      expect(item.description).to be_a String
      expect(item.thumbnail_url).to be_a String
      expect(item.published_at).to be_a Time
      expect(item.channel_id).to be_a String
      expect(item.channel_title).to be_a String
      expect(item.playlist_id).to be_a String
      expect(item.position).to be_an Integer
      expect(item.video_id).to be_a String
      expect(item.video).to be_a Youhub::Models::Video
    end
  end

  context 'given an unknown playlist item' do
    let(:id) { 'not-a-playlist-item-id' }

    it { expect { item.snippet }.to raise_error Youhub::Errors::RequestError }
  end
end
