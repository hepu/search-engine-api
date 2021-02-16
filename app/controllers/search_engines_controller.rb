# frozen_string_literal: true

class SearchEnginesController < ApplicationController
  before_action :validate_engine

  VALID_ENGINES = %w[google bing both].freeze

  def search
    @text = search_params[:text]

    render json: { engine: @engine, text: @text }
  end

  private

  def search_params
    params.permit(:engine, :text)
  end

  def validate_engine
    @engine = search_params[:engine]

    return render_error("'engine' param is required") if @engine.blank?

    return render_error("Invalid engine: #{@engine}") unless VALID_ENGINES.include?(@engine&.downcase)
  end
end
