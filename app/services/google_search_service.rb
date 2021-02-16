# frozen_string_literal: true

require 'google/api'

class GoogleSearchService
  def initialize(query, page: nil, per_page: 10)
    @query = query
    @page = page
    @per_page = per_page
  end

  def call
    result = Google::Api.search(@query, page: @page, per_page: @per_page)

    {
      engine: 'google',
      items: result['items'].map { |item| item_extractor(item) },
      pagination: { page: @page, per_page: @per_page }
    }
  end

  private

  def item_extractor(item)
    {
      source: 'google',
      url: item['link'],
      title: item['title'],
      description: item['snippet'],
      displayUrl: item['displayLink']
    }
  end
end
