# frozen_string_literal: true

require 'youhub/models/base'

module Youhub
  module Models
    # Provides methods to interact with YouTube Analyouhubics bulk report jobs.
    # @see https://developers.google.com/youtube/reporting/v1/reference/rest/v1/jobs
    class BulkReportJob < Base
      # @private
      attr_reader :id, :auth, :report_type_id

      # @private
      def initialize(options = {})
        @id = options[:id]
        @auth = options[:auth]
        @report_type_id = options[:report_type_id]
      end

      # @!attribute [r] bulk_reports
      #   @return [Youhub::Collections::BulkReports] the bulk reports of this job.
      has_many :bulk_reports
    end
  end
end
