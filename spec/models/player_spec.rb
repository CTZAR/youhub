# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/player'

describe Youhub::Player do
  subject(:player) { Youhub::Player.new data: data }

  describe '#data' do
    let(:data) { { 'key' => 'value' } }
    specify 'returns the data the player was initialized with' do
      expect(player.data).to eq data
    end
  end
end
