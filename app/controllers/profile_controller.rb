class ProfileController < ApplicationController
  layout "internal"

  def edit
  
  end

  def update
    
     if current_user.update(profile_params)
        redirect_to root_url
      else
        render "edit"
     end
  end

  private
  def profile_params
    params.permit(:name,:avatar)
  end
end
