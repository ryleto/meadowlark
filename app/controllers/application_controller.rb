class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  after_filter :prepare_unobtrusive_flash
  
  def unobtrusive_flash_domain
    request.host # last resort is hardcoding the domain here
  end
  
  private
  
    # Confirms user is logged in
    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url, alert: "Please log in."
      end
    end
end

