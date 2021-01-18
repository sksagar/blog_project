class HomeController < ApplicationController

  LIMITS_PER_PAGE = 4

  def index
    @page = (params[:page] || 1 ).to_i
    @articles = Article.all

    if params[:tag_id].present?
       
      @tag = Tag.find(params[:tag_id])
      @articles = @tag.articles
     
    end

    
    if params[:search].present?
      
      @articles = @articles.where("lower(title)  LIKE ? OR content LIKE ?","%#{params[:search]}%","%#{params[:search]}%")

    end

    @rows = @articles.count
    @total_pages = (@rows / LIMITS_PER_PAGE.to_f).ceil
    @articles = @articles.order('updated_at DESC').offset((@page - 1) * LIMITS_PER_PAGE).limit(LIMITS_PER_PAGE)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show_articles
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = @article.comments
  end

end
