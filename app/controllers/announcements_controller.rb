class AnnouncementsController < ApplicationController
  respond_to :html, :json

  def index
    respond_with @announcements
  end
end
