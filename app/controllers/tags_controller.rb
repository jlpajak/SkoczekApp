class TagsController < ApplicationController
  
  before_action :set_tag, only: [:edit, :update, :show]
  before_action :require_admin, except: [:show, :index]
  
  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = "Tag was successfully created"
      redirect_to tag_path(@tag)
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @tag.update(tag_params)
      flash[:success] = "Tag name was updated successfully"
      redirect_to @tag
    else
      render 'edit'
    end
  end
  
  def show
    @tag_articles = @tag.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def index
    @tags = Tag.paginate(page: params[:page], per_page: 5)
  end
  
  private
  
    def tag_params
      params.require(:tag).permit(:name)
    end
  
    def set_tag
      @tag = Tag.find(params[:id])
    end
  
    def require_admin
      if !logged_in? || (logged_in? and !current_player.admin?)
        flash[:danger] = "Only admin users can perform that action"
        redirect_to tags_path
      end
    end
  
end