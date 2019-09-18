# frozen_string_literal: true

require 'spec_helper'
require 'youhub/collections/videos'
require 'youhub/models/channel'

describe Youhub::Collections::Videos do
  subject(:collection) { Youhub::Collections::Videos.new parent: channel }
  let(:channel) { Youhub::Channel.new id: 'any-id' }
  let(:page) { { items: [], token: 'any-token' } }

  describe '#size', :ruby2 do
    describe 'sends only one request and return the total results' do
      let(:total_results) { 123_456 }
      before do
        expect_any_instance_of(Youhub::Request).to receive(:run).once do
          double(body: { 'pageInfo' => { 'totalResults' => total_results } })
        end
      end
      it { expect(collection.size).to be total_results }
    end
  end

  describe '#count' do
    let(:query) { { q: 'search string' } }

    context 'called once with .where(query) and once without' do
      after do
        collection.where(query).count
        collection.count
      end

      it 'only applies the query on the first call' do
        expect(collection).to receive(:fetch_page) do |options|
          expect(options[:params]).to include query
          page
        end
        expect(collection).to receive(:fetch_page) do |options|
          expect(options[:params]).not_to include query
          page
        end
      end
    end
  end
end
