# frozen_string_literal: true

require 'rails_helper'
require 'bing/api'

RSpec.describe Bing::Api do
  describe '.search' do
    context 'when response code is 200' do
      before do
        allow(Bing::Api).to receive(:get) do
          create_test_response({
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
                               }, 200)
        end
      end

      it "returns the response" do
        expect(described_class.search('test').parsed_response['webPages']['value'].count).to eq(2)
      end
    end

    context 'when response code is not 200' do
      before do
        allow(Bing::Api).to receive(:get) do
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
