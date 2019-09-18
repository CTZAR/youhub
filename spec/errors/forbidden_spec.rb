# frozen_string_literal: true

require 'spec_helper'
require 'youhub/errors/forbidden'

describe Youhub::Errors::Forbidden do
  let(:msg) { /^A request to YouTube API was considered forbidden by the server/ }

  describe '#exception' do
    it { expect { raise Youhub::Errors::Forbidden }.to raise_error msg }
  end
end
