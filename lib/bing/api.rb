# frozen_string_literal: true

module Bing
  class Api
    include HTTParty
    base_uri 'https://api.bing.microsoft.com'

    PER_PAGE = 10

    class << self
      def search(query, page: 1, per_page: PER_PAGE)
        response = get(
          "/v7.0/search",
          headers: {
            'Ocp-Apim-Subscription-Key' => ENV['BING_API_KEY']
          },
          query: {
            q: query,
            count: per_page + 1,
            offset: offset_per_page(page, per_page + 1)
          }
        )
        puts response.body.inspect
        raise 'Error from Bing API' if response.code != 200

        response
      end

      private

      def offset_per_page(page, per_page)
        return 0 if page <= 1

        (page - 1) * per_page
      end
    end
  end
end
