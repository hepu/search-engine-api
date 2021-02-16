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

    return render_error("'engine' param is required", :bad_request) if @engine.blank?

    return if SearchService::ENGINES.values.include?(@engine&.downcase)

    render_error("Invalid engine: #{@engine}", :not_acceptable)
  end

  def render_search_error(error)
    render_error({
      message: error.message,
      backtrace: error.backtrace
    })
  end
end
