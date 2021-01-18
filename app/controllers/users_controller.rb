class UsersController < ApplicationController
  layout "sessions"
  before_action :check_signup, only: [:new,:create]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path
    else
      render "new"
    end

 
  end
  

  private

  def user_params
    params.require(:user).permit(:name,:email,:password)
  end

  def check_signup
    if current_user.present? 
      redirect_to root_url
    end
  end

end
