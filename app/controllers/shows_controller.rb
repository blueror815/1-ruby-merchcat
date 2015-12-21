class ShowsController < ApplicationController
  require 'json'

  before_action :check_session
  before_action :set_token
  skip_before_filter :verify_authenticity_token, :only => [:info, :report, :email]

  layout :layout

  @@export = false

  @@show = nil
  @@items = []

  def index
  end

  def info
    shows = params[:shows] ? params[:shows].to_a : []
    shows = shows.map { |s| s[1] }
    @shows = shows.select { |s| s['deleted_state'] == 'false' and s['num_sales'].to_i > 0 }
  end

  def detail
    @show_id = params[:id]    
    @@export = params[:export]    

    @show = @@show
    @items = @@items

    respond_to do |format|
      format.html
      format.xls 
      format.pdf do
        render :pdf => 'Settlment PDF',
        :template => 'shows/settlement.pdf.erb',
        :layout => 'pdf.html.erb',
        :disposition => 'attachment'
      end
    end
  end

  def report
    @show_id = params[:id]
    @api_token = params[:token] unless @api_token
    @export = @@export
    map_sales
    
    @@show = @show
    @@items = @items
  end

  def email
    to = params[:email]
    map_sales
    if @sales && @show && @items && SettlementMailer.build_settlement_email(to, @sales, @show, @items).deliver_now
      render json: { status: :ok, message: 'mail sent'}, status: :created
    else
      render json: { message: 'mail not sent'}, status: :internal_server_error
    end
  end
      
  private

  def set_token
    @api_token = current_token
    @is_mobile = is_mobile?
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

  def map_sales
    sales = params[:sales] ? params[:sales] : {}
    @sales = sales.map { |s| s[1] }
    @show = nil
    @items = []
    @sales.each do |sale|
      @show = sale['show'] unless @show
      items = sale['items'].to_a.map { |item| item[1] }
      @items += items
    end
  end

end
