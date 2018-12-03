class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.where(user: current_user)
    @favorites = Favorite.all
    @markers = @favorites.map do |favorite|
      {
        lat: favorite.lat,
        lng: favorite.long
      }
    end
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
