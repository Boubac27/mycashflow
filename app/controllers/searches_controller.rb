class SearchesController < ApplicationController

  def index
    if params[:search].present?
      @results_base = Collecteur.new(search_params, current_user).collecter[:prices]
      @results = @results_base.sort_by { |appt| appt[:returns] }.reverse
      ap @results
    else
      @results = []
      ap @results
    end
  end

  def new
    @search = Search.new
    @user = current_user
  end

  def create
    @results_base = Collecteur.new(search_params, current_user).collecter[:prices]
    @results = @results_base.sort_by { |appt| appt[:returns] }.reverse
    puts "Create"
    ap @results
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
