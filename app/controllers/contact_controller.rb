class ContactController < ApplicationController
  def index
  end

  def send_email
    name = contact_params[:name]
    email = contact_params[:email]
    message = contact_params[:message]
    if ContactMailer.build_email(name, email, message).deliver_now
      render json: { status: :ok, message: 'mail sent'}, status: :created
    else
      render json: { message: 'mail not sent'}, status: :internal_server_error
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end

end
