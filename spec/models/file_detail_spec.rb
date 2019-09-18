# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/file_detail'

describe Youhub::FileDetail do
  subject(:file_detail) { Youhub::FileDetail.new data: data }

  describe '#data' do
    let(:data) { { 'key' => 'value' } }
    specify 'returns the data the file detail was initialized with' do
      expect(file_detail.data).to eq data
    end
  end
end
