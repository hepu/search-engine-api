class ApplicationController < ActionController::API
  protected

  def render_error(message)
    render json: { error: message }, status: :internal_server_error
  end
end
