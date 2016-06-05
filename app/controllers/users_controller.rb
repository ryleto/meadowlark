class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @comments = @user.comments.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      redirect_to root_url, notice: "Please check your email to activate your account."
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, notice: "Profile updated"
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy 
    redirect_to users_url, notice: "User deleted"
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # before actions
    
    # confirms user is logged in
    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url, alert: 'You must log in first to continue'
      end
    end
    
    # confirms current user matches assigned user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # confirms current user is admin
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
