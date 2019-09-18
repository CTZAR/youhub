# frozen_string_literal: true

require 'spec_helper'
require 'youhub/errors/request_error'

describe Youhub::Errors::RequestError do
  subject(:error) { raise Youhub::Errors::RequestError, params }
  let(:params) { {} }
  let(:msg) { /^A request to YouTube API failed/ }

  describe '#exception' do
    it { expect { error }.to raise_error msg }

    context 'given the exception includes sensitive data' do
      let(:body) { 'some secret token' }
      let(:curl) { 'curl -H "Authorization: secret-token"' }
      let(:params) { { response_body: body, request_curl: curl }.to_json }

      describe 'given a log level of :debug or :devel' do
        before(:all) { Youhub.configuration.log_level = :debug }
        specify 'exposes sensitive data' do
          expect { error }.to raise_error do |error|
            expect(error.message).to include 'secret'
          end
        end
      end

      describe 'given a different log level' do
        before(:all) { Youhub.configuration.log_level = :info }
        specify 'hides sensitive data' do
          expect { error }.to raise_error do |error|
            expect(error.message).not_to include 'secret'
          end
        end
      end
    end
  end
end

describe Youhub::Error do
  let(:msg) { /^A request to YouTube API failed/ }

  describe '#exception' do
    it { expect { raise Youhub::Error }.to raise_error msg }
  end
end
