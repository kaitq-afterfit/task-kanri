class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def show
    @user = User.find(params[:id])
  end

  def new
    # => registrations#new
  end

  def create
    # => registrations#create
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    # User.find(params[:id]).destroy
    # flash[:success] = "User deleted"
    # redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def admin_user
      redirect_to(root_url) unless current_user.is_admin?
    end

    def correct_user
      @user = User.find(params[:id])
      unless (@user == current_user)
        # render :file => "#{Rails.public_path}/401.html", :status => :unauthorized
        flash[:danger] = "You are not authorized to that page."
        redirect_to(root_url)
      end
    end
end
