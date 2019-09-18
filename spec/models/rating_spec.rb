# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/rating'

describe Youhub::Rating do
  subject(:rating) { Youhub::Rating.new }

  describe '#update' do
    before { expect(rating).to receive(:do_update).and_yield }

    it { expect { rating.set :like }.to change { rating.rating } }
  end
end
