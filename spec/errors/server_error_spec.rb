# frozen_string_literal: true

require 'spec_helper'
require 'youhub/errors/server_error'

describe Youhub::Errors::ServerError do
  let(:msg) { /^A request to YouTube API caused an unexpected server error/ }

  describe '#exception' do
    it { expect { raise Youhub::Errors::ServerError }.to raise_error msg }
  end
end
