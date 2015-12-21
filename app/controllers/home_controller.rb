class HomeController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index

  end

  def send_email
  	@to = params[:email]
  	@new_pass = params[:password]
    
    if @to && @new_pass && PasswordMailer.build_password_email(@to, @new_pass).deliver_now
      render json: { status: :ok, message: 'mail sent'}, status: :created
    else
      render json: { message: 'mail not sent'}, status: :internal_server_error
    end  	
  end

end
