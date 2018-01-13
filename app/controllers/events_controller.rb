class EventsController < ApplicationController
  respond_to :html, :json

  def index
    @events = Event.all
    respond_with @events
  end

  def new
    @event = Event.new
    respond_with @event
  end

  def show
    @event = Event.find_by(id: params[:id])
    respond_with @event
  end

  def create
    return head status: :forbidden unless admin_signed_in? and current_admin.approved?
    event = Event.new(event_parameters_create)
    if event.save
      head status: :created, location: event_path(event)
    else
      render json: {error: event.errors}, status: :bad_request
    end
  end

  def destroy
    event = Event.find_by(id: params[:id])
    return head status: :not_found unless event
    return head status: :forbidden unless admin_signed_in?
    event.destroy
    head status: :ok
  end

  private

  def event_parameters_create
    parameters = params.require(:event).permit(:title, :description, :location, :start_time, :end_time)
    parameters
  end
end
