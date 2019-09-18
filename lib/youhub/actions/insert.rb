# frozen_string_literal: true

require 'youhub/request'
require 'youhub/actions/base'
require 'youhub/config'

module Youhub
  module Actions
    module Insert
      include Base

      private

      def do_insert(extra_insert_params = {})
        response = insert_request(extra_insert_params).run
        @items = []
        new_item extract_data_from(response)
      end

      def insert_request(params = {})
        Youhub::Request.new(insert_params.deep_merge(params)).tap do |request|
          print "#{request.as_curl}\n" if Youhub.configuration.developing?
        end
      end

      def insert_params
        path = "/youtube/v3/#{self.class.to_s.demodulize.camelize :lower}"

        {}.tap do |params|
          params[:path] = path
          params[:host] = 'www.googleapis.com'
          params[:method] = :post
          params[:auth] = @auth
          params[:expected_response] = Net::HTTPOK
          params[:api_key] = Youhub.configuration.api_key if Youhub.configuration.api_key
        end
      end

      def extract_data_from(response)
        response.body
      end
    end
  end
end
