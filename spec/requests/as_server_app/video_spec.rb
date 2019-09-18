# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/video'
require 'youhub/collections/comment_threads'

describe Youhub::Video, :server_app do
  subject(:video) { Youhub::Video.new attrs }

  context 'given an existing video ID' do
    let(:attrs) { { id: '9bZkp7q19f0' } }

    it { expect(video.content_detail).to be_a Youhub::ContentDetail }

    it 'returns valid snippet data' do
      expect(video.snippet).to be_a Youhub::Snippet
      expect(video.title).to be_a String
      expect(video.description).to be_a String
      expect(video.thumbnail_url).to be_a String
      expect(video.published_at).to be_a Time
      expect(video.tags).to be_an Array
      expect(video.channel_id).to be_a String
      expect(video.channel_title).to be_a String
      expect(video.channel_url).to be_a String
      expect(video.category_id).to be_a String
      expect(video.live_broadcast_content).to be_a String
    end

    it { expect(video.status).to be_a Youhub::Status }
    it { expect(video.statistics_set).to be_a Youhub::StatisticsSet }
  end

  context 'given an unknown video ID' do
    let(:attrs) { { id: 'not-a-video-id' } }

    it { expect { video.content_detail }.to raise_error Youhub::Errors::NoItems }
    it { expect { video.snippet }.to raise_error Youhub::Errors::NoItems }
    it { expect { video.status }.to raise_error Youhub::Errors::NoItems }
    it { expect { video.statistics_set }.to raise_error Youhub::Errors::NoItems }
  end

  describe 'associations' do
    let(:attrs) { { id: 'MsplPPW7tFo' } }

    describe '#comment_threads' do
      it { expect(video.comment_threads).to be_a Youhub::Collections::CommentThreads }
      it { expect(video.comment_threads.first.top_level_comment).to be_a Youhub::Models::Comment }
    end

    describe '#comment_threads.each_cons' do
      it {
        comment_threads = []
        video.comment_threads.each_cons(2).take_while do |items|
          comment_threads += items
          comment_threads.size < 6
        end
        expect(comment_threads.size).to be 6
      }
    end
  end
end
