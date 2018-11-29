class ProgressesController < ApplicationController
  def index
    @progress = Progress.where("user_id=?", current_user.id).first
    @scale = @progress.scale
  end
end
