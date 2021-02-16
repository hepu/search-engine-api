# frozen_string_literal: true

require 'rails_helper'
require 'bing/api'

RSpec.describe BingSearchService do
  before do
    allow(Bing::Api).to receive(:search) do
      {
        'webPages': {
          'value': [
            {
              'url': 'http://bing.com',
              'name': 'Bing',
              'snippet': 'Just another mock',
              'displayUrl': 'bing.com'
            },
            {
              'url': 'http://facebook.com',
              'name': 'Facebook',
              'snippet': 'Another one',
              'displayUrl': 'facebook.com'
            }
          ]
        }
      }.with_indifferent_access
    end
  end

  describe '#call' do
    it "returns the search results" do
      expect(described_class.new('test').call[:items].count).to eq(2)
    end
  end
end
