class WidgetsController < ApplicationController

  before_action :check_session

  layout 'admin_application'

  def index
  end

end
