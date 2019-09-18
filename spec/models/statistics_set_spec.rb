# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/statistics_set'

describe Youhub::StatisticsSet do
  subject(:statistics_set) { Youhub::StatisticsSet.new data: data }

  describe '#data' do
    let(:data) { { 'key' => 'value' } }
    specify 'returns the data the statistics set was initialized with' do
      expect(statistics_set.data).to eq data
    end
  end
end
