# frozen_string_literal: true

RSpec::Matchers.define :fail do
  supports_block_expectations
  match do |block|
    block.call
    false
  rescue Youhub::Error => e
    @reason ? e.reasons.include?(@reason) : true
  end

  chain :with do |reason|
    @reason = reason
  end
end
