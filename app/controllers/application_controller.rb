class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  before_action :set_token, except: [:new, :create]

  def check_session
    redirect_to '/' unless signed_in?
  end

  def set_token
    sign_in params[:token] if params[:token]
    @token = current_token
  end

  def is_mobile?
    request.env['HTTP_USER_AGENT'].downcase =~ /iphone|ipod|ipad.*applewebkit(?!.*safari)/
  end
end
