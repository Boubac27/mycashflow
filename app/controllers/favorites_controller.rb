class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.where(user: current_user)
    @favorites = Favorite.all
  end

  # GET /favorites/:id
  def show
    @favorite = Favorite.find(params[:id])
  end

  def create
  end

  def update
    p "dans update"
    @favorite = Favorite.find(params[:id])
    if @favorite.update(favorite_params)
      redirect_to favorite_path(@favorite)
    else
      p "bug!!!"
    end
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
      :work
    )
  end
end
