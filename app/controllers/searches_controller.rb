class SearchesController < ApplicationController

  def new
    @search = Search.new
    @user = current_user
  end

  def create
    coll = Collecteur.new(search_params)
    @price_n_rents = coll.collecter
    @prices = @price_n_rents[:prices]
    @rents = @price_n_rents[:rents]

  end

  def update
  end

  private

  def search_params
    params.require(:search).permit(:city, :zipcode, :budget)
  end

end
