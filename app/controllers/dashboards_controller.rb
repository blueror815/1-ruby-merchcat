class DashboardsController < ApplicationController

  before_action :check_session

  layout 'admin_application'

  def dashboard_1
  end

  def dashboard_2
    @api_token = current_token
    @is_mobile = is_mobile?
  end

  def dashboard_3
    @extra_class = "sidebar-content"
  end

  def dashboard_4
    render :layout => "layout_2"
  end

  def dashboard_4_1
  end

  def dashboard_5
  end

end
