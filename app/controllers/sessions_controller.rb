class SessionsController < ApplicationController
  
  def new
    
  end

  def create
    player = Player.find_by(email: params[:session][:email].downcase)
    if player && player.authenticate(params[:session][:password])
      session[:player_id] = player.id
      cookies.signed[:player_id] = player.id
      flash[:success] = "You have successfully logged in"
      redirect_to player
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end

  def destroy
    session[:player_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

end 