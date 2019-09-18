# frozen_string_literal: true

require 'spec_helper'
require 'youhub/collections/playlists'

describe Youhub::Collections::Playlists do
  subject(:collection) { Youhub::Collections::Playlists.new }
  before { expect(collection).to behave }

  describe '#insert' do
    let(:playlist) { Youhub::Playlist.new }
    # TODO: separate stubs to show options translate into do_insert params
    let(:behave) { receive(:do_insert).and_return playlist }

    it { expect(collection.insert).to eq playlist }
  end

  describe '#delete_all' do
    let(:behave) { receive(:do_delete_all).and_return [true] }

    it { expect(collection.delete_all).to eq [true] }
  end

  describe '#delete_all' do
    let(:behave) { receive(:do_delete_all).and_return [true] }

    it { expect(collection.delete_all).to eq [true] }
  end
end
