class PushNotificationTokensController < ApplicationController
  respond_to :html
  skip_before_action :verify_authenticity_token

  def create
    token = PushNotificationToken.new(token_parameters_create)
    if token.save
      head :created
    else
      render json: {error: token.errors}, status: :bad_request
    end
  end

  def send 
    exponent = Exponent::Push::Client.new
    messages = []

    PushNotificationToken.all.each do |token|
      messages.push({
        to: token,
        body: params[:message]
      })
    end
    
    exponent.publish messages
  end

  private

  def token_parameters_create
    parameters = params.require(:push_notification_token).permit(:token)
    parameters
  end
end
