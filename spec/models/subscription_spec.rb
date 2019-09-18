# frozen_string_literal: true

require 'spec_helper'
require 'youhub/models/subscription'

describe Youhub::Subscription do
  subject(:subscription) { Youhub::Subscription.new id: id }

  describe '#exists?' do
    context 'given a subscription with an id' do
      let(:id) { 'CBl6OoF0BpiV' }
      it { expect(subscription).to exist }
    end

    context 'given a subscription without an id' do
      let(:id) { nil }
      it { expect(subscription).not_to exist }
    end
  end

  describe '#delete' do
    let(:id) { 'CBl6OoF0BpiV' }
    before { expect(subscription).to behave }

    context 'given an existing subscription' do
      let(:behave) { receive(:do_delete).and_yield }

      it { expect(subscription.delete).to be true }
      it { expect { subscription.delete }.to change { subscription.exists? } }
    end
  end
end
