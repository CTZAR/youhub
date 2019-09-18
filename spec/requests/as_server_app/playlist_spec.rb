# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/playlist'

describe Youhub::Playlist, :server_app do
  subject(:playlist) { Youhub::Playlist.new attrs }

  context 'given an existing playlist ID' do
    let(:attrs) { { id: 'PLSWYkYzOrPMT9pJG5St5G0WDalhRzGkU4' } }

    it 'returns valid snippet data' do
      expect(playlist.snippet).to be_a Youhub::Snippet
      expect(playlist.title).to be_a String
      expect(playlist.description).to be_a String
      expect(playlist.thumbnail_url).to be_a String
      expect(playlist.published_at).to be_a Time
      expect(playlist.tags).to be_an Array
      expect(playlist.channel_id).to be_a String
      expect(playlist.channel_title).to be_a String
      expect(playlist.item_count).to be_an Integer
    end

    it { expect(playlist.status).to be_a Youhub::Status }
    it { expect(playlist.playlist_items).to be_a Youhub::Collections::PlaylistItems }
    it { expect(playlist.playlist_items.first).to be_a Youhub::PlaylistItem }
  end

  context 'given an unknown playlist' do
    let(:attrs) { { id: 'not-a-playlist-id' } }

    it { expect { playlist.snippet }.to raise_error Youhub::Errors::NoItems }
    it { expect { playlist.status }.to raise_error Youhub::Errors::NoItems }
  end
end
