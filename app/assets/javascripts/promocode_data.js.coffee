class PromoJS
  @promos_data = null

  constructor: ->
    #do nothing just yet


# function for showing subscribers data

  showPromosData: =>
    api_token = mct
    if @promos_data
      promosjs.parsePromosPanelDataAndUpdateUI(@promos_data)

    if api_token
      $.ajax
        type: "GET"
        url: merchapi.host() + "/pcodes?token=#{api_token}&per_page=100"
        headers:
          'Accept': 'application/json'
        async: true
        success: (promos_data) ->
          @promos_data = promos_data
          promosjs.parsePromosPanelDataAndUpdateUI(@promos_data)
          
          $("#promos").load("/promocode/info", {"promos":promos_data}, (responseText, textStatus, xhr) ->
            console.log "textStatus: #{textStatus}"
            
          )

        error: (data) ->
          $("#subscribers").text("Error loading subscribers.")
    else
      	$("#subscribers").text("Error loading subscribers.")


# parsing response from API to get subscribers data.

  parsePromosPanelDataAndUpdateUI : (promos_data) =>


  getTotalRevenue: =>
    total_revenue = $("#total-revenue")
    total_revenue.text 'Loading...'
    api_token = mct

    if @promos_data
      promosjs.parsePromosDataAndUpdateUI(sales)
    else if api_token
      $.ajax
        type: "GET"
        url: merchapi.host() + "/sales?token=#{api_token}"
        headers:
          'Accept': 'application/json'
        async: true
        success: (sales) ->
          @sales_data = sales
          promosjs.parsePromosDataAndUpdateUI(sales)
        error: (data) ->
          total_revenue.text 'Error Loading Total Income'
    else
      total_revenue.text 'Error Loading Total Income'

  parsePromosDataAndUpdateUI: (sales) =>
    total_revenue = $("#total-revenue") 
    total_usd_sold = 0.00
    for sale in sales
      total_usd_sold += +sale.amount 
    total_revenue.text "$#{promosjs.round(total_usd_sold, 2)}"

  round: (number, precision) =>
    precision = Math.abs(parseInt(precision)) || 0
    multiplier = Math.pow(10, precision)
    Math.round(number * multiplier) / multiplier


  stopEvent: (e) ->
    alert("Stoped")
    e.preventDefault()
    e.stopPropagation()

@promosjs = new PromoJS("")
@promosjs.showPromosData()
@promosjs.getTotalRevenue()
