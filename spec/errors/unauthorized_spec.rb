# frozen_string_literal: true

require 'spec_helper'
require 'youhub/errors/unauthorized'

describe Youhub::Errors::Unauthorized do
  let(:msg) { /^A request to YouTube API was sent without a valid authentication/ }

  describe '#exception' do
    it { expect { raise Youhub::Errors::Unauthorized }.to raise_error msg }
  end
end
