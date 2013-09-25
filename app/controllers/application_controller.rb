class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  
  private

  def require_user
    unless current_user
      redirect_to root_path
    end
  end

  def current_user
    return nil if session[:access_token].blank?
    User.find_by(:access_token => session[:access_token])
  end
end
