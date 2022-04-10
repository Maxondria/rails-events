class EventsController < ApplicationController
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]

  def index
    @events = Event.upcoming
  end

  def show
    @event = Event.find(params[:id])
    @likers = @event.likers

    @like = current_user.likes.find_by(event_id: @event.id) if current_user
    @categories = @event.categories
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event, notice: 'Event successfully updated!'
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
      redirect_to @event, notice: 'Event successfully created!'
    else
      render :new # render the new template of the same controller
    end
  end

  def destroy
    @event = Event.find(params[:id])

    if @event.destroy
      redirect_to events_path, alert: 'Event successfully deleted!'
    else
      render :show # render the show template of the same controller
    end
  end

  private

  def event_params
    params
      .require(:event)
      .permit(
        :name,
        :description,
        :location,
        :price,
        :image_file_name,
        :capacity,
        :starts_at,
        category_ids: [],
      )
  end
end
