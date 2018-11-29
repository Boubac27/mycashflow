class ProgressesController < ApplicationController
  def index
    @progress = Progress.where("user_id=?", current_user.id).first
    @scale = {}
    @scale[:scale] = @progress.scale if !@progress.nil?
    render json: @scale
  end
end
