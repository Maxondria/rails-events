class EventsController < ApplicationController
  def index
    @events = Event.upcoming
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render :edit # render the edit template of the same controller
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event
    else
      render :new # render the new template of the same controller
    end
  end

  def destroy
    @event = Event.find(params[:id])

    if @event.destroy
      redirect_to events_path
    else
      render :show # render the show template of the same controller
    end
  end

  private

  def event_params
    params
      .require(:event)
      .permit(:name, :description, :location, :price, :starts_at)
  end
end
