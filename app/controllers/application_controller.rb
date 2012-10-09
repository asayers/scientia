class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_authenticated
    flash[:notice] = "You're not authorised to do this"
    redirect_back_or_to root_url
  end
end
