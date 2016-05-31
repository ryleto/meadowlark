class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to root_url, notice: "Email sent with password reset instructions"
    else
      render 'new', alert: "Email address not found"
    end
  end
  
  def edit
  end
  
  def update
    if password_blank?
      render 'edit', alert: "Password cannot be blank"
    elsif @user.update_attribute(user_params)
      log_in @user
      redirect_to @user, notice: "Password has be reset"
    else
      render 'edit'
    end
  end
      
  private
    
    def user_params
      params.require(:user) .permit(:password, :password_confirmation)
    end
    
    # Returns true if password is blank
    def password_blank?
      params[:user][:password].blank?
    end
    
    # Before filters
    
    def get_user
      @user = User.find_by(email: params[:email])
    end

    # Confirms a valid user.
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
    
    # Checks expiration of reset token
    def check_expiration
      if @user.password_reset_expired?
        redirect_to new_password_reset_url, alert: "Password reset has expired."
      end
    end
end
