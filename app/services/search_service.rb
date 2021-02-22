#  frozen_string_literal: true

class SearchService
  ENGINES = { google: 'google', bing: 'bing', both: 'both' }.freeze

  def initialize(text, engine:, page: 1)
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
        engine: ENGINES[:both],
        items: merge_results(google_result, bing_result),
        pagination: { page: @page, per_page: 10 }
      }
    end
  end

  private

  def merge_results(search_result1, search_result2)
    merged_result = search_result1[:items]
    search_result_urls = search_result1[:items].map { |search_result| search_result[:url] }

    search_result2[:items].each do |search_result|
      duplicated_result_index = search_result_urls.index(search_result[:url])
      if duplicated_result_index
        merged_result[duplicated_result_index][:duplicate_count] ||= 0
        merged_result[duplicated_result_index][:duplicate_count] += 1
      else
        merged_result << search_result
      end
    end

    merged_result
  end
end
