# frozen_string_literal: true

require 'youhub/collections/base'
require 'youhub/models/bulk_report_job'

module Youhub
  module Collections
    # @private
    class BulkReportJobs < Base
      private

      def attributes_for_new_item(data)
        { id: data['id'], auth: @auth, report_type_id: data['reportTypeId'] }
      end

      def list_params
        super.tap do |params|
          params[:host] = 'youtubereporting.googleapis.com'
          params[:path] = '/v1/jobs'
          params[:params] = { on_behalf_of_content_owner: @parent.owner_name }
        end
      end

      def items_key
        'jobs'
      end
    end
  end
end
