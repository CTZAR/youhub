# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/video_category'

describe Youhub::VideoCategory do
  subject(:video_category) { Youhub::VideoCategory.new attrs }

  describe '#id' do
    context 'given fetching a video category returns an id' do
      let(:attrs) { { id: '22' } }
      it { expect(video_category.id).to eq '22' }
    end
  end

  describe '#snippet' do
    context 'given fetching a video category returns a snippet' do
      let(:attrs) { { snippet: { "title": 'People & Blogs', "assignable": true } } }

      it { expect(video_category.snippet).to be_a Youhub::Snippet }
    end
  end
end
