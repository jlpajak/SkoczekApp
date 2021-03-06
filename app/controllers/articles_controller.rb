class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:show, :edit, :update, :destroy, :like]
  before_action :require_user, except: [:index, :show, :like]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_user_like, only: [:like]

  def index
     @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    @comment = Comment.new
    @comments = @article.comments.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.player = current_player
    if @article.save
      flash[:success] = "Article was created successfully!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def edit

  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was updated successfully!"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "Article deleted successfully"
    redirect_to articles_path
  end
  
  def like
    like = Like.create(like: params[:like], player: current_player, article: @article)
    if like.valid?
      flash[:success] = "Your selection was succesful"
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a article once"
      redirect_to :back
    end
  end

  private
  
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:name, :description, :image, tag_ids: [])
    end
  
    def require_same_user
      if current_player != @article.player and !current_player.admin?
        flash[:danger] = "You can only edit or delete your own articles"
        redirect_to articles_path
      end  
    end
  
    def require_user_like
      if !logged_in?
        flash[:danger] = "You must be logged in to perform that action"
        redirect_to :back
      end
    end

end