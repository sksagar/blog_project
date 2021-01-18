class CommentsController < ApplicationController

  before_action :need_login


  def create

    @comment = current_user.comments.new(comment_params)
    
    if @comment.save
      redirect_to home_show_path(id: @comment.article_id)
    else
      render "show_articles"
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:article_id,:description)
  end

  def need_login
    if current_user.nil?
      flash[:alert] = "you must be logged in to access this section"
      redirect_to root_url

    end
  end
end
