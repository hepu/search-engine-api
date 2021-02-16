# frozen_string_literal: true

module Google
  class Api
    include HTTParty
    base_uri 'https://www.googleapis.com'

    PER_PAGE = 10

    class << self
      def search(query, page: 1, per_page: PER_PAGE)
        response = get(
          "/customsearch/v1",
          query: {
            key: ENV['GOOGLE_API_KEY'],
            cx: ENV['GOOGLE_SEARCH_ENGINE_ID'],
            q: query,
            num: per_page,
            start: offset_per_page(page, per_page)
          }
        )

        raise "Error from Google API: #{response.body.inspect}" if response.code != 200

        response
      end

      private

      def offset_per_page(page, per_page)
        return 0 if page <= 1

        move_to_next_page_index = 1

        ((page - 1) * per_page) + move_to_next_page_index
      end
    end
  end
end
