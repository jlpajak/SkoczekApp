class PlayersController < ApplicationController
  
  def index
    @players = Player.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      flash[:success] = "Welcome #{@player.playername} to STW App!"
      redirect_to player_path(@player)
    else
      render 'new'
    end
  end
  
  def show
    @player = Player.find(params[:id])
    @player_articles = @player.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
    @player = Player.find(params[:id])
  end
  
  def update
    @player = Player.find(params[:id])
    if @player.update(player_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to @player
    else
      render 'edit'
    end  
  end

  private
  
    def player_params
      params.require(:player).permit(:playername, :email, :password, :password_confirmation)
    end
  
end