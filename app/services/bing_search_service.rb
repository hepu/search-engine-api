# frozen_string_literal: true

require 'bing/api'

class BingSearchService
  def initialize(query, page: nil, per_page: 10)
    @query = query
    @page = page
    @per_page = per_page
  end

  def call
    result = Bing::Api.search(@query, page: @page, per_page: @per_page)

    {
      engine: 'bing',
      items: result['webPages']['value'].map { |item| item_extractor(item) },
      pagination: { page: @page, per_page: @per_page }
    }
  end

  private

  def item_extractor(item)
    {
      source: 'bing',
      url: item['url'],
      title: item['name'],
      description: item['snippet'],
      displayUrl: item['displayUrl']
    }
  end
end
