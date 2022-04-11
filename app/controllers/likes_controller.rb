class LikesController < ApplicationController
  before_action :require_signin
  before_action :set_event, only: %i[create destroy]

  def create
    unless @event.likers.include?(current_user)
      @event.likers << current_user

      # same as: @event.likes.create!(user: current_user)
      # same as: current_user.likes.create!(event: @event)
      # same as: like = Like.new(user: current_user, event: @event).save
    end

    redirect_to @event, notice: 'Thanks for liking!'
  end

  def destroy
    @event.likers.delete(current_user) if @event.likers.include?(current_user)

    # OR

    # like = current_user.likes.find(params[:id])
    # like.destroy

    redirect_to @event, alert: 'Sorry to see you go!'
  end

  private

  def set_event
    @event = Event.find_by!(slug: params[:event_id])
  end
end
