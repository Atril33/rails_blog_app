class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, only: [:create]

  before_action :authenticate_user!
  protect_from_forgery with: :exception

  def after_sign_in_path_for(_resource)
    users_path
  end

  def after_sending_reset_password_instructions_path_for(resource_name)
    new_session_path(resource_name) if is_navigational_format?
  end
end
