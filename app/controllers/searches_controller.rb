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

  def create
    @results_base = Collecteur.new(search_params, current_user).collecter[:prices]
    @results = @results_base.sort_by { |appt| appt[:returns] }.reverse
    @prices = @results
    # UserMailer.welcome(current_user, @results).deliver_now
    render 'create.js'
  end

  def update
  end

  private

  def search_params
    params.require(:search).permit(:city, :zipcode, :budget)
  end
end
