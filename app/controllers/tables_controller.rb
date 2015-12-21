class TablesController < ApplicationController

  before_action :check_session

  layout 'admin_application'

  def static_tables
  end

  def data_tables
  end

  def foo_tables
  end

  def jqgrid
  end

end
