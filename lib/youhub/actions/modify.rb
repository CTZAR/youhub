# frozen_string_literal: true

require 'youhub/request'
require 'youhub/actions/base'
require 'youhub/config'

module Youhub
  module Actions
    # Abstract module that contains methods common to Delete and Update
    module Modify
      include Base

      private

      def do_modify(params = {})
        response = modify_request(params).run
        yield response.body if block_given?
      end

      def modify_request(params = {})
        Youhub::Request.new(params).tap do |request|
          print "#{request.as_curl}\n" if Youhub.configuration.developing?
        end
      end

      def modify_params
        path = "/youtube/v3/#{self.class.to_s.demodulize.pluralize.camelize :lower}"

        {}.tap do |params|
          params[:path] = path
          params[:auth] = @auth
          params[:host] = 'www.googleapis.com'
          params[:expected_response] = Net::HTTPNoContent
          params[:api_key] = Youhub.configuration.api_key if Youhub.configuration.api_key
        end
      end
    end
  end
end
