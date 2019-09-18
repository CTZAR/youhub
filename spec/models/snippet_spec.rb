# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/snippet'

describe Youhub::Snippet do
  subject(:snippet) { Youhub::Snippet.new data: data }

  describe '#data' do
    let(:data) { { 'key' => 'value' } }
    specify 'returns the data the snippet was initialized with' do
      expect(snippet.data).to eq data
    end
  end
end
