# frozen_string_literal: true

require 'youhub/config'
require 'youhub/models/account'
require 'youhub/models/content_owner'

RSpec.configure do |config|
  # Create one global test account to avoid having to refresh the access token
  # at every request
  config.before :all do
    attrs = { refresh_token: ENV['YOUHUB_TEST_DEVICE_REFRESH_TOKEN'] }
    $account = Youhub::Account.new attrs
  end

  # Don't use authentication from env variables unless specified with a tag
  config.before :all do
    Youhub.configure do |config|
      config.client_id = nil
      config.client_secret = nil
      config.api_key = nil
    end
  end

  config.before :all, device_app: true do
    Youhub.configure do |config|
      config.client_id = ENV['YOUHUB_TEST_DEVICE_CLIENT_ID']
      config.client_secret = ENV['YOUHUB_TEST_DEVICE_CLIENT_SECRET']
      config.log_level = ENV['YOUHUB_LOG_LEVEL']
    end
  end

  config.before :all, server_app: true do
    Youhub.configure do |config|
      config.api_key = ENV['YOUHUB_TEST_SERVER_API_KEY']
      config.log_level = ENV['YOUHUB_LOG_LEVEL']
    end
  end

  config.before :all, partner: true do
    Youhub.configure do |config|
      config.client_id = ENV['YOUHUB_TEST_PARTNER_CLIENT_ID']
      config.client_secret = ENV['YOUHUB_TEST_PARTNER_CLIENT_SECRET']
      config.log_level = ENV['YOUHUB_LOG_LEVEL']
    end
    # Create one Youtube Partner channel, authenticated as the content owner
    attrs = { refresh_token: ENV['YOUHUB_TEST_CONTENT_OWNER_REFRESH_TOKEN'] }
    attrs[:owner_name] = ENV['YOUHUB_TEST_CONTENT_OWNER_NAME']
    $content_owner = Youhub::ContentOwner.new attrs
  end
end
