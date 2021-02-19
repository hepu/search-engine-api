# frozen_string_literal: true

class SearchEnginesController < ApplicationController
  rescue_from StandardError, with: :render_search_error

  def search
    @search = Search.new
    @search.assign_attributes(search_params)

    if @search.valid?
      render json: SearchService.new(@search.text, engine: @search.engine, page: @search.page&.to_i || 1).call
    else
      render_error(@search.errors.full_messages.to_sentence, :bad_request)
    end
  end

  private

  def search_params
    params.permit(:engine, :text, :page)
  end

  def render_search_error(error)
    Rails.logger.error("A search error occurred: #{error.message}")
    render_error("A search error occurred: #{error.message}")
  end
end
