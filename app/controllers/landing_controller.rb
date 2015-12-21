class LandingController < ApplicationController

  before_action :check_session

  layout 'admin_application'

  def index
    render :layout => "empty"
  end

end