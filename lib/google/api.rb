# frozen_string_literal: true

module Google
  class Api
    include HTTParty
    base_uri 'https://www.googleapis.com'

    class << self
      def search(query)
        api_key = ENV['GOOGLE_API_KEY']
        cx = ENV['GOOGLE_SEARCH_ENGINE_ID']

        response = get("/customsearch/v1", query: { key: api_key, cx: cx, q: query })

        raise 'Error from Google API' if response.code != 200

        response
      rescue StandardError => e
        {
          error: e.message
        }
      end
    end
  end
end
