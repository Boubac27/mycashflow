class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def create
    @results = Collecteur.new(search_params).collecter[:prices]
    render 'create.js'
  end

  def update
  end

  private

  def search_params
    params.require(:search).permit(:city, :zipcode, :budget)
  end

end
