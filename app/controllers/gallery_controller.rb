class GalleryController < ApplicationController

  before_action :check_session

  layout 'admin_application'

  def basic_gallery
  end

  def bootstrap_carusela
  end

  def slick_carusela
  end

end
