class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def log_in(user)
    session[:user_id] = user.id
    flash[:notice] = "You've logged in!"
    redirect_to root_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "Log in or Register to do that."
      redirect_to :back
    end
  end

  def require_admin
    access_denied unless logged_in? &&  current_user.admin?
  end

  def access_denied
    flash[:error] = "Access Denied"
    redirect_to root_path
  end
end
