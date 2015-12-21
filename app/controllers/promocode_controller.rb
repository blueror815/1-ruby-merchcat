class PromocodeController < ApplicationController

	require 'json'

  	before_action :check_session
  	before_action :set_token
  	skip_before_filter :verify_authenticity_token, :only => [:info, :report]

  	layout :layout

	def index
	end

	def info
		if params[:promos]
			promos_data = params[:promos] ? params[:promos].to_a : []
	    	@promos = promos_data.map { |s| s[1] }
	    end
	end

	private

	def set_token
	    @api_token = current_token
	end

	def layout
	    case action_name
	       	when 'detail'
		        params['export'] ? false : 'admin_application'
		  	when 'info', 'report'
		        false
	      	else
		        'admin_application'
	    end
  	end
end
