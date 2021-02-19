# frozen_string_literal: true

require 'rails_helper'
require 'google/api'
require 'bing/api'

RSpec.describe SearchEnginesController, type: :request do
  describe 'GET search' do
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

    context 'when engine param is not sent' do
      before do
        get search_path, params: { text: 'something' }
      end

      it "returns a 400 status code" do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when engine param is present' do
      context 'and is google' do
        before do
          get search_path, params: { text: 'something', engine: 'google' }
        end

        it "returns a 200 status code" do
          expect(response).to have_http_status(:ok)
        end

        it "returns items as a result" do
          expect(parsed_response['items'].count).to eq(1)
        end
      end

      context 'and is bing' do
        before do
          get search_path, params: { text: 'else', engine: 'bing' }
        end

        it "returns a 200 status code" do
          expect(response).to have_http_status(:ok)
        end

        it "returns items as a result" do
          expect(parsed_response['items'].count).to eq(2)
        end
      end

      context 'and is both' do
        before do
          get search_path, params: { text: 'find', engine: 'both' }
        end

        it "returns a 200 status code" do
          expect(response).to have_http_status(:ok)
        end

        it "returns items as a result" do
          expect(parsed_response['items'].count).to eq(3)
        end
      end

      context 'and is a different value' do
        before do
          get search_path, params: { text: 'else', engine: 'bong' }
        end

        it "returns a 400 status code" do
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end
end
