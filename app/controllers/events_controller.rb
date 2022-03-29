class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    event_params = params
      .require(:event)
      .permit(:name, :description, :location, :price, :starts_at)

    if @event.update(event_params)
      redirect_to @event
    else
      render :edit # render the edit template of the same controller
    end
  end
end
