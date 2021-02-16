# frozen_string_literal: true

class SearchEnginesController < ApplicationController
  before_action :validate_engine

  rescue_from StandardError, with: :render_search_error

  def search
    render json: SearchService.new(search_params[:text], engine: @engine, page: search_params[:page]&.to_i || 1).call
  end

  private

  def search_params
    params.permit(:engine, :text, :page)
  end

  def validate_engine
    @engine = search_params[:engine]

    return render_error("'engine' param is required") if @engine.blank?

    return render_error("Invalid engine: #{@engine}") unless SearchService::ENGINES.values.include?(@engine&.downcase)
  end

  def render_search_error(error)
    render_error("A search error occurred: #{error.message}")
  end
end
