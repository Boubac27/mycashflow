class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.where(user: current_user)
    @favorites = Favorite.all
  end

  def show
  end

  def create
    scraped = params[:scraped]
    elements = scraped.split("&")
    hash_fav = {}
    elements.each do |el|
      keyval = el.split("=")
      key = keyval[0]
      value = keyval[1]
      case key
      when "price", "rendement", "lat", "lng"
        value = value.to_f
      when "rooms", "surface", "user_id"
        value = value.to_i
      end
      hash_fav[key.to_sym] = value
    end
    @fav = Favorite.new(hash_fav)
    if @fav.save
      redirect_to favorites_path
    else
      ap "bug"
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to favorites_path
  end

  private

  def index_params
    params.require(:favorites).permit(:price)
  end

end
