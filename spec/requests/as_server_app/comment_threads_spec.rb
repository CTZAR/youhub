# frozen_string_literal: true

require 'spec_helper'
require 'youhub/collections/comment_threads'
require 'youhub/models/video'
require 'youhub/models/channel'

describe Youhub::Collections::CommentThreads, :server_app do
  context 'without parent association', :ruby2 do
    subject(:comment_threads) { Youhub::Collections::CommentThreads.new }

    specify 'without given any of id, videoId, channelId or allThreadsRelatedToChannelId param, raise request error', :ruby2 do
      expect { comment_threads.size }.to raise_error(Youhub::Errors::RequestError)
    end

    specify 'with a id param, only return one comment thread' do
      expect(comment_threads.where(id: 'z13zyouhubsilxbexh30e233gdyyouhubtngfjfz104').size).to eq 1
    end

    specify 'with a videoId param, returns comment threads for the video', focus: true do
      expect(comment_threads.where(videoId: 'MsplPPW7tFo').size).to be > 0
    end

    specify 'with a channelId param, returns comment threads for the channel' do
      expect(comment_threads.where(channelId: 'UC-lHJZR3Gqxm24_Vd_AJ5Yw').size).to be > 0
    end
  end

  context 'with parent association', :ruby2 do
    subject(:comment_threads) { Youhub::Collections::CommentThreads.new parent: parent }

    context 'parent as video' do
      let(:parent) { Youhub::Models::Video.new id: 'MsplPPW7tFo' }
      it { expect(comment_threads.size).to be > 0 }
    end

    context 'parent as channel' do
      let(:parent) { Youhub::Models::Channel.new id: 'UC-lHJZR3Gqxm24_Vd_AJ5Yw' }
      it { expect(comment_threads.size).to be > 0 }
    end
  end
end
