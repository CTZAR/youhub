# frozen_string_literal: true

require 'spec_helper'
require 'youhub/collections/reports'
require 'youhub/models/content_owner'

describe Youhub::Collections::Reports do
  subject(:reports) { Youhub::Collections::Reports.new(parent: content_owner).tap { |reports| reports.metrics = { views: Integer } } }
  let(:content_owner) { Youhub::ContentOwner.new owner_name: 'any-name' }
  let(:error) { { reason: reason, message: message } }
  let(:msg) { { response_body: { error: { errors: [error] } } }.to_json }

  describe '#within' do
    let(:result) { reports.within Range.new(5.days.ago, 4.days.ago), nil, nil, :day, nil, nil }
    context 'given the request raises error 400 with "Invalid Query" message' do
      let(:reason) { 'badRequest' }
      let(:message) { 'Invalid query. Query did not conform to the expectations' }
      before { expect(reports).to receive(:list).once.and_raise Youhub::Error, msg }
      let(:try_again) { expect(reports).to receive(:list).at_least(:once) }

      context 'every time' do
        before { try_again.and_raise Youhub::Error, msg }
        it { expect { result }.to raise }
      end

      context 'but returns a success code 2XX the second time' do
        before { try_again.and_return [views: { total: 20 }] }
        it { expect { result }.not_to raise }
      end
    end
  end
end
