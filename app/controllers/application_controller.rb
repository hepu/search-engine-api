class ApplicationController < ActionController::API
  protected

  def render_error(message, status = :internal_server_error)
    render json: { error: message }, status: status
  end
end
