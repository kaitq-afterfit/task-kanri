class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

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

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
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
