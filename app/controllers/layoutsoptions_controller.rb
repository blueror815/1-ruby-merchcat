class LayoutsoptionsController < ApplicationController

  before_action :check_session

  layout 'admin_application'

  def index
  end

  def off_canvas
    render :layout => "layout_4"
  end

end