class ApplicationController < ActionController::API
  protected

  def render_error(message)
    render json: { error: message }, status: :forbidden
  end
end
