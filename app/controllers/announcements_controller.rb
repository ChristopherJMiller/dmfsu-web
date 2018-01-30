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
    not_found unless @announcement
    respond_with @announcement
  end

  def create
    return head :forbidden unless admin_signed_in? and current_admin.approved?
    announcement = Announcement.new(announcement_parameters_create)
    if announcement.save
      head :created, location: announcement_path(announcement)
    else
      render json: {error: announcement.errors}, status: :bad_request
    end
  end

  def destroy
    announcement = Announcement.find_by(id: params[:id])
    return head :not_found unless announcement
    return head :forbidden unless admin_signed_in? and current_admin.approved?
    announcement.destroy
    head :ok
  end

  private

  def announcement_parameters_create
    parameters = params.require(:announcement).permit(:title, :post)
    parameters[:admin] = current_admin
    parameters
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
