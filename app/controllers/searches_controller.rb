class SearchesController < ApplicationController

  def index
    if params[:search].present?
      @results_base = Collecteur.new(search_params, current_user).collecter[:prices]
      @results = @results_base.sort_by { |appt| appt[:returns] }.reverse
    else
      @results = []
    end
  end

  def new
    @search = Search.new
    @user = current_user
  end

  def destroy
    @search = Search.find(params[:id])
    @search.destroy
  end

  def create
    scrap_lbc
    search = Search.new(search_params)
    search.last_scrap = Date.current
    search.user = current_user
    search.save
    render 'create.js'
  end

  def update
  end

  def save

  end

  private

  def scrap_lbc
    @results_base = Collecteur.new(search_params).collecter[:prices]
    @results = @results_base.sort_by { |appt| appt[:returns] }.reverse
    @prices = @results
  end

  def search_params
    params.require(:search).permit(:city, :zipcode, :budget)
  end
end
