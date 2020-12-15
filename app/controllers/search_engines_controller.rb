class SearchEnginesController < ApplicationController
  before_action :validate_engine

  VALID_ENGINES = %w[google bing both].freeze

  def search
    @query = search_params[:query]

    render json: { engine: @engine, query: @query }
  end

  private

  def search_params
    params.permit(:engine)
  end

  def validate_engine
    @engine = search_params[:engine]

    return render_error("engine param is required") if @engine.blank?

    return render_error("Invalid engine: #{@engine}") unless VALID_ENGINES.include?(@engine&.downcase)
  end
end
