class ProgressesController < ApplicationController
  def index
    @progress = Progress.where("user_id=?", current_user.id).first
    @scale = {}
    if !@progress.nil?
      # blink = @progress[:blink]
      @scale[:scale] = @progress.scale
      # blink = blink.zero? ? 1 : 0
      # Progress.update(@progress.id, blink: blink)
      # @scale[:blink] = blink
    end
    render json: @scale
  end
end
