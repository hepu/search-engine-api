# frozen_string_literal: true

require 'rails_helper'
require 'google/api'

RSpec.describe Google::Api do
  describe '.search' do
    context 'when response code is 200' do
      before do
        allow(Google::Api).to receive(:get) do
          create_test_response({
                                 'items': [
                                   {
                                     'link': 'http://google.com',
                                     'title': 'Google',
                                     'snippet': 'Just another mock',
                                     'displayLink': 'google.com'
                                   }
                                 ]
                               }, 200)
        end
      end

      it "returns the response" do
        expect(described_class.search('test').parsed_response['items'].count).to eq(1)
      end
    end

    context 'when response code is not 200' do
      before do
        allow(Google::Api).to receive(:get) do
          create_test_response({
                                 'error': 'any error'
                               }, 500)
        end
      end

      it "raises an error" do
        expect do
          described_class.search('test')
        end.to raise_error RuntimeError
      end
    end
  end
end
