# frozen_string_literal: true

require 'rails_helper'
require 'google/api'
require 'bing/api'

RSpec.describe SearchService do
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
    context 'when engine is google' do
      it "returns the google search service result" do
        expect(described_class.new('test', engine: described_class::ENGINES[:google]).call[:items].count).to eq(1)
      end
    end

    context 'when engine is bing' do
      it "returns the bing search service result" do
        expect(described_class.new('test', engine: described_class::ENGINES[:bing]).call[:items].count).to eq(2)
      end
    end

    context 'when engine is both' do
      context "when search results are different" do
        it "returns the google and bing search service results" do
          expect(described_class.new('test', engine: described_class::ENGINES[:both]).call[:items].count).to eq(3)
        end
      end
      
      context 'when there are similar search results' do
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
                    'url': 'http://google.com',
                    'name': 'Google',
                    'snippet': 'Just another mock',
                    'displayLink': 'google.com'
                  }
                ]
              }
            }.with_indifferent_access
          end
        end

        it "returns the google and bing search service results without duplicates" do
          expect(described_class.new('test', engine: described_class::ENGINES[:both]).call[:items].count).to eq(2)
        end
        
        it "returns a duplicate_count for the duplicated search result" do
          expect(described_class.new('test', engine: described_class::ENGINES[:both]).call[:items][0][:duplicate_count]).to eq(1)
        end
      end
    end
  end
end
