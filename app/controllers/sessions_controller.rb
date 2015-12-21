class SessionsController < ApplicationController

  def create
    token = params[:token]
    uber_admin = params[:uber_admin]

    if token.nil? || token.blank?
      flash[:notice] = 'An error has occurred. Please try again.'
      render json: {:status => 'failed', :errors => ['No token provided.']}, status: :bad_request
    else
      sign_in token
      set_uber uber_admin
      render json: {:status => 'success'}, status: :created
    end
  end

  def destroy
    sign_out
    redirect_to '/'
  end

end