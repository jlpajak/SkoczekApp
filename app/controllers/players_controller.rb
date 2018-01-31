class PlayersController < ApplicationController
  
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def index
    @players = Player.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      session[:player_id] = @player.id
      cookies.signed[:player_id] = @player.id
      flash[:success] = "Welcome #{@player.playername} to STW App!"
      redirect_to player_path(@player)
    else
      render 'new'
    end
  end
  
  def show
    @player_articles = @player.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
  end
  
  def update
    if @player.update(player_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to @player
    else
      render 'edit'
    end  
  end
  
  def destroy
    if !@player.admin?
      @player.destroy
      flash[:danger] = "Player and all associated articles have been deleted"
      redirect_to players_path
    end
  end

  private
  
    def player_params
      params.require(:player).permit(:playername, :email, :password, :password_confirmation)
    end
  
    def set_player
      @player = Player.find(params[:id])
    end
  
    def require_same_user
      if current_player != @player and !current_player.admin?
        flash[:danger] = "You can only edit or delete your own account"
        redirect_to articles_path
      end  
    end
  
    def require_admin
      if logged_in? && !current_player.admin?
        flash[:danger] = "Only admin can perform that action"
        redirect_to root_path
      end  
    end
  
end