class ArticlesController < ApplicationController
 
  layout "internal"
  

  before_action :require_login
  before_action :check_id, only: [:edit,:update,:show,:delete]
  

  LIMITS_PER_PAGE = 4

  def index
   
    @page = (params[:page] || 1).to_i
    @articles = current_user.articles

    if params[:sort_by] == "title_asc"
      @articles = @articles.order("lower(title) ASC")
    elsif params[:sort_by] == "title_dsc"
      @articles = @articles.order("lower(title) DESC")
    elsif params[:sort_by] == "newest_first"
      @articles = @articles.order("created_at DESC")
    elsif params[:sort_by] == "oldest_first"
      @articles = @articles.order("created_at ASC")
    end

    @rows = @articles.count
    @total_pages =(@rows / LIMITS_PER_PAGE.to_f).ceil
    @articles = @articles.offset((@page-1) * LIMITS_PER_PAGE).limit(LIMITS_PER_PAGE)
    
  end


  def new
    @article = Article.new
  end
  

  def create
    
    @article = current_user.articles.new(article_params)
    @article.tag_ids = params[:tag_ids]

    if @article.save
      redirect_to articles_path
    else
      render "new"
    end
  end


  def show
    @articles = Article.all
    @article = Article.find(params[:id])
  end


  def edit
    @article = Article.find(params[:id])
  end


  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to articles_path
    else
      render "edit"
    end
  end


  def destroy
    @article = Article.find(params[:id])

    @article.destroy

    redirect_to articles_path

  end


  private

  def article_params
    params.require(:article).permit(:title,:content)
  end

  def require_login
    if current_user.nil?
      flash[:error] = "you must be logged in to access this section"
      redirect_to root_url
    end
  end
  
  def check_id
    @article = Article.find(params[:id])
    if @article.user_id == current_user.id
    else
      redirect_to articles_path
    end
  end


end
