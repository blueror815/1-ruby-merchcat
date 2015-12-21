class ConfirmationController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:send_confirmation]

  def send_confirmation
    duration = pcode_params[:pcode_duration] ? pcode_params[:pcode_duration].to_i : 30
    expiration = Time.now + duration.days
    email = contact_params[:email]
    if ConfirmationMailer.build_confirmation(email, duration, expiration).deliver_now
      render json: { status: :ok, message: 'mail sent'}, status: :created
    else
      render json: { message: 'mail not sent'}, status: :internal_server_error
    end
  end

  private

  def pcode_params
    params.permit(:pcode_duration)
  end

  def contact_params
    params.require(:contact).permit(:email)
  end
end
