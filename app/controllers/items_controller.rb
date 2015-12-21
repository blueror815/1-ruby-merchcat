class ItemsController < ApplicationController
  require 'json'

  before_action :check_session
  skip_before_filter :verify_authenticity_token, :only => [:info]

  layout :layout

  def info
    items = params[:items] if params[:items]
    @items = items.select { |item| item['deleted_state'] != 'false' } if items
  end

  private

  def layout
    case action_name
      when 'info'
        false
      else
        'admin_application'
    end
  end

end
