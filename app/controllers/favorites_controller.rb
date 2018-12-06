class FavoritesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

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

  # GET /favorites/:id/
  def show
    @favorite = Favorite.find(params[:id])
  end

  def create
    scraped = params[:scraped]
    ap params[:scraped]
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

    respond_to do |format|
      if @fav.save
        format.html { redirect_to favorites_path }
        format.js { }
      end
    end
  end

  def update
    @favorite = Favorite.find(params[:id])
    @favorite.update(favorite_params)
    redirect_to favorite_path(@favorite)
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to favorites_path
  end

  private

  def favorite_params
    params.require(:favorite).permit(
      :property_taxe,
      :insurance,
      :total_rent,
      :monthy_loan,
      :rental_charges,
      :total_rent,
      :work,
      :city,
      :urlscrap,
      :avg_rents
    )
  end

  def index_params
    params.require(:favorites).permit(:price, :city, :avg_rents)
  end
end
