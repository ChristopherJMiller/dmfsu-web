class AnnouncementsController < ApplicationController
  respond_to :html, :json

  def index
    @announcements = Announcement.all
    respond_with @announcements
  end

  def new
    @announcement = Announcement.new
    respond_with @announcement
  end

  def show
    @announcement = Announcement.find_by(id: params[:id])
    respond_with @announcement
  end

  def create
    return head status: :forbidden unless admin_signed_in?
    announcement = Announcement.new(announcement_parameters_create)
    if announcement.save
      head status: :created, location: announcement_path(announcement)
    else
      render json: {error: announcement.errors}, status: :bad_request
    end
  end

  private

  def announcement_parameters_create
    parameters = params.require(:announcement).permit(:title, :post)
    parameters[:admin] = current_admin
    parameters
  end
end
