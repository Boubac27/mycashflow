class FavoritesController < ApplicationController
  def index

    @favorites = Favorite.where(user: current_user)

    @favorites = Favorite.all

  end

  def show
  end

  def create

  end


  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to favorites_path
  end
end
