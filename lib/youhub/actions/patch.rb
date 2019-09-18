# frozen_string_literal: true

require 'youhub/actions/modify'

module Youhub
  module Actions
    module Patch
      include Modify

      private

      def do_patch(extra_patch_params = {}, &block)
        do_modify patch_params.deep_merge(extra_patch_params), &block
      end

      def patch_params
        modify_params.tap { |params| params[:method] = :patch }
      end
    end
  end
end
