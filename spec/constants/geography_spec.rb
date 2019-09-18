# frozen_string_literal: true

require 'spec_helper'
require 'youhub/constants/geography'

describe 'Youhub::COUNTRIES' do
  it 'returns all country codes and names' do
    expect(Youhub::COUNTRIES[:US]).to eq 'United States'
    expect(Youhub::COUNTRIES['IT']).to eq 'Italy'
  end
end

describe 'Youhub::US_STATES' do
  it 'returns all U.S. state codes and names' do
    expect(Youhub::US_STATES[:CA]).to eq 'California'
    expect(Youhub::US_STATES['CO']).to eq 'Colorado'
  end
end
