class ApplicationController < ActionController::Base
  # Add a custom flash key to the flash hash
  add_flash_types :danger

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  # declares this method as part of the view helper methods
  helper_method :current_user
  helper_method :current_user?

  def require_signin
    unless current_user
      session[:previous_url] = request.url
      redirect_to signin_path, alert: "Please sign in first!"
    end
  end
end
