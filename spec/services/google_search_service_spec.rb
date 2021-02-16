# frozen_string_literal: true

require 'rails_helper'
require 'google/api'

RSpec.describe GoogleSearchService do
  before do
    allow(Google::Api).to receive(:search).and_return({
      'items': [
        {
          'link': 'http://google.com',
          'title': 'Google',
          'snippet': 'Just another mock',
          'displayLink': 'google.com'
        }
      ]
    }.with_indifferent_access)
  end

  describe '#call' do
    it "returns the search results" do
      expect(described_class.new('test').call[:items].count).to eq(1)
    end
  end
end
