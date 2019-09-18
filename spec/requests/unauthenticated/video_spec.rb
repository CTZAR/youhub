# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/video'

describe Youhub::Video do
  subject(:video) { Youhub::Video.new id: id }

  context 'given a public video with annotations' do
    let(:id) { '9bZkp7q19f0' }

    it { expect(video.annotations).to be_a Youhub::Collections::Annotations }
    it { expect(video.annotations.first).to be_a Youhub::Annotation }
    it { expect(video.annotations.size).to be > 0 }
  end
end
