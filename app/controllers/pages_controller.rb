class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :autocomplete]

  def home
  end

  def autocomplete

  end
end
