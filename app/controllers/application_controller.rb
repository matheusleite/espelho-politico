class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
# :nocov:
  def get_raw_connection
    conn = ActiveRecord::Base.connection
    conn
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:user) {|u| u.permit(:name, :email, :password, :username, :password_confirmation)}
    devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(:username, :password, :remember_me)}
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :username, :password_confirmation)}
  end

  def ensure_signup_complete
    return if action_name == 'finish_signup'
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end
# :nocov:
end
