# frozen_string_literal: true

require 'spec_helper'
require 'youhub/errors/missing_auth'

describe Youhub::Errors::MissingAuth do
  subject(:error) { raise Youhub::Errors::MissingAuth, params }
  let(:params) { {} }
  let(:msg) { /^A request to YouTube API was sent without a valid authentication/ }

  describe '#exception' do
    it { expect { error }.to raise_error msg }

    context 'given the user can authenticate via web' do
      let(:params) { { scopes: 'youtube', authentication_url: 'http://google.example.com/auth', redirect_uri: 'http://localhost/' } }
      let(:msg) { /^You can ask YouTube accounts to authenticate your app/ }
      it { expect { error }.to raise_error msg }
    end

    context 'given the user can authenticate via device code' do
      let(:params) { { scopes: 'youtube', user_code: 'abcdefgh', verification_url: 'http://google.com/device' } }
      let(:msg) { /^Please authenticate your app by visiting the page/ }
      it { expect { error }.to raise_error msg }
    end
  end
end
