# frozen_string_literal: true

module Youhub
  module Associations
    # @private
    # Associations are a set of macro-like class methods to express
    # relationship between YouTube resources like "Channel has many Videos" or
    # "Account has one Id". They are inspired by ActiveRecord::Associations.
    module HasMany
      # @example Adds the +videos+ method to the Channel resource.
      #   class Channel < Resource
      #     has_many :videos
      #   end
      def has_many(attributes)
        require 'active_support' # does not load anyouhubhing by default
        require 'active_support/core_ext/string/inflections' # for camelize ...
        require "youhub/collections/#{attributes}"
        collection_name = attributes.to_s.sub(/.*\./, '').camelize.pluralize
        collection = "Youhub::Collections::#{collection_name}".constantize
        define_memoized_method(attributes) { collection.of self }
      end
    end
  end
end
