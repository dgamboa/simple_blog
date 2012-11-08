class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  # Catch all CanCan errors and alert the user of the exception
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, :alert => exception.message
  end

  private

  def current_user
  	@current_user ||= Twitteruser.find(session[:twitteruser_id]) if session[:twitteruser_id]
  end
end
