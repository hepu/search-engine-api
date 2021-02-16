#  frozen_string_literal: true

class SearchService
  ENGINES = { google: 'google', bing: 'bing', both: 'both' }.freeze

  def initialize(text, engine:, page:)
    @text = text
    @engine = engine
    @page = page
  end

  def call
    case @engine
    when ENGINES[:google]
      GoogleSearchService.new(@text, page: @page).call
    when ENGINES[:bing]
      BingSearchService.new(@text, page: @page).call
    when ENGINES[:both]
      google_result = GoogleSearchService.new(@text, page: @page, per_page: 5).call
      bing_result = BingSearchService.new(@text, page: @page, per_page: 5).call

      {
        items: google_result[:items].concat(bing_result[:items]),
        pagination: {
          page: @page,
          per_page: 10
        }
      }
    end
  end
end
