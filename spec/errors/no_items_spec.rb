# frozen_string_literal: true

require 'spec_helper'
require 'youhub/errors/no_items'

describe Youhub::Errors::NoItems do
  let(:msg) { /^A request to YouTube API returned no items/ }

  describe '#exception' do
    it { expect { raise Youhub::Errors::NoItems }.to raise_error msg }
  end
end
