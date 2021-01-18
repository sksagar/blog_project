class SessionsController < ApplicationController
  layout "sessions"

  before_action :check_login, only: [:new,:create]

  def new
    
  end

  def create

    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to articles_path, notice: "log in successful"

    else
      flash.now.alert = "invalid email or password"
      render "new"
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "log out successful" 
  end

  private

  def check_login
    if current_user.present? 
      redirect_to root_url
    end
  end
end
