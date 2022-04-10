class LikesController < ApplicationController
  before_action :require_signin

  def create
    event = Event.find(params[:event_id])

    unless event.likers.include?(current_user)
      event.likers << current_user

      # same as: @event.likes.create!(user: current_user)
      # same as: current_user.likes.create!(event: @event)
      # same as: like = Like.new(user: current_user, event: @event).save
    end

    redirect_to @event, notice: 'Thanks for liking!'
  end

  def destroy
    event = Event.find(params[:event_id])

    event.likers.delete(current_user) if event.likers.include?(current_user)

    # OR

    # like = current_user.likes.find(params[:id])
    # like.destroy

    redirect_to event, alert: 'Sorry to see you go!'
  end
end
