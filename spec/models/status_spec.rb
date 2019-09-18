# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/status'

describe Youhub::Status do
  subject(:status) { Youhub::Status.new data: data }

  describe '#data' do
    let(:data) { { 'key' => 'value' } }
    specify 'returns the data the status was initialized with' do
      expect(status.data).to eq data
    end
  end
end
