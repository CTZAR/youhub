# frozen_string_literal: true

require 'youhub/actions/delete'
require 'youhub/actions/update'
require 'youhub/actions/patch'

require 'youhub/associations/has_attribute'
require 'youhub/associations/has_authentication'
require 'youhub/associations/has_many'
require 'youhub/associations/has_one'
require 'youhub/associations/has_reports'

require 'youhub/errors/request_error'

module Youhub
  module Models
    # @private
    class Base
      include Actions::Delete
      include Actions::Update
      include Actions::Patch

      include Associations::HasAttribute
      extend Associations::HasReports
      extend Associations::HasOne
      extend Associations::HasMany
      extend Associations::HasAuthentication
    end
  end

  # By including Models in the main namespace, models can be initialized with
  # the shorter notation Youhub::Video.new, rather than Youhub::Models::Video.new.
  include Models
end
