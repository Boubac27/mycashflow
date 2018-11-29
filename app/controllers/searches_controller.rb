class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def create
    @results_base = Collecteur.new(search_params, current_user).collecter[:prices]
    @results = @results_base.sort_by { |appt| appt[:returns] }.reverse
    @prices = @results
    @progress = Progress.where("user_id=?", current_user.id)
    @progress.destroy_all
    render 'create.js'
  end

  def update
  end

  private

  def search_params
    params.require(:search).permit(:city, :zipcode, :budget)
  end

end
