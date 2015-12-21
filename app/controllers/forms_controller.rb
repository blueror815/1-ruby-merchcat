class FormsController < ApplicationController

  before_action :check_session
  
  layout 'admin_application'

  def basic_forms
  end

  def advanced
  end

  def wizard
  end

  def file_upload
  end

  def text_editor
  end

end
