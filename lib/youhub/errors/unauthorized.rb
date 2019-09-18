# frozen_string_literal: true

require 'youhub/errors/request_error'
require 'youhub/config'

module Youhub
  module Errors
    class Unauthorized < RequestError
      def explanation
        'A request to YouTube API was sent without a valid authentication'
      end

      private

      def more_details
        if [Youhub.configuration.client_id, Youhub.configuration.api_key].none?
          <<-MSG.gsub(/^ {10}/, '')
          In order to perform this request, you need to register your app with
          Google Developers Console (https://console.developers.google.com).

          Make sure your app has access to the Google+ and YouTube APIs.

          If your app requires read-only access to public YouTube data, then
          generate a server API key and set its value with the initializer:

          Youhub.configure do |config|
            config.api_key = '123456789012345678901234567890'
          end

          or through an environment variable:

          export YOUHUB_API_KEY="123456789012345678901234567890"

          If your app needs to perform actions on behalf of YouTube accounts,
          then generate a client ID and SECRET and set their values with the
          initializer:

          Youhub.configure do |config|
            config.client_id = '1234567890.apps.googleusercontent.com'
            config.client_secret = '1234567890'
          end

          or through environment variables:

          export YOUHUB_CLIENT_ID="1234567890.apps.googleusercontent.com"
          export YOUHUB_CLIENT_SECRET="1234567890"
          MSG
        end
      end
    end
  end
end
