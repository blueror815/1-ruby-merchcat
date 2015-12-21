class DashboardDataJS

  @sales_data = null
  @user = null

  constructor: ->
    #do nothing just yet

  getSalesData: =>
    total_revenue = $("#total_revenue")
    show_sales_label = $("#show_sales_label")
    order_label = $("#order_label")
    items_label = $("#items_label")
    total_revenue.text 'Loading...'
    show_sales_label.text 'Loading Show Sales...'
    order_label.text 'Loading...'
    items_label.text 'Loading Items Sold...'
    api_token = mct
    if @sales_data
      dashboardDataJS.parseSalesDataAndUpdateUI(sales)
    else if api_token
      $.ajax
        type: "GET"
        url: merchapi.host() + "/sales?token=#{api_token}&per_page=100"
        headers:
          'Accept': 'application/json'
        async: true
        success: (sales) ->
          @sales_data = sales
          dashboardDataJS.parseSalesDataAndUpdateUI(sales)
        error: (data) ->
          total_revenue.text 'Error Loading Total Income'
          show_sales_label.text 'Error Loading Show Sales'
          order_label.text 'Error Loading Orders'
          items_label.text 'Error Loading Items Sold'
    else
      total_revenue.text 'Error Loading Total Income'
      show_sales_label.text 'Error Loading Show Sales'
      order_label.text 'Error Loading Orders'
      items_label.text 'Error Loading Items Sold'

  parseSalesDataAndUpdateUI: (sales) =>
    income_label = $("#income_label")
    total_revenue = $("#total-revenue")
    six_month_revenue = $("#six_month_revenue")
    show_sales_label = $("#show_sales_label")
    order_label = $("#order_label")
    items_label = $("#items_label")
    average_cart = $("#average_cart")

    total_usd_sold = 0.00
    for sale in sales
      total_usd_sold += +sale.amount
    income_label.text "$#{dashboardDataJS.round(total_usd_sold, 2)}"
    total_revenue.text "$#{dashboardDataJS.round(total_usd_sold, 2)}"

    average = total_usd_sold / sales.length if sales.length > 0
    average = 0 unless average
    average_cart.text "$#{dashboardDataJS.round(average, 2).toFixed(2)}"

    #TODO: break this out into a separate API call that retrieves the 6 month revenue total
    six_month_revenue.text "$#{dashboardDataJS.round(total_usd_sold, 2)}"

    show_usd_sold = 0.00
    total_items_sold = 0
    for sale in sales
      total_usd_sold += sale.amount if sale.show_id?
      for cart_item in sale.items
        total_items_sold += cart_item.quantity_in_cart
      
    order_label.text "#{total_items_sold}"
    show_sales_label.text "$#{show_usd_sold}"

    #TODO: Update this to loop through each sale item within sales and get the sale.items.length once available from the API
    items_label.text "#{sales.length}"

    dashboardDataJS.buildSalesBarChart(sales)

  buildSalesBarChart: (sales) =>
    # Options for Bar chart
    singleBarOptions =
      scaleBeginAtZero: true
      scaleShowGridLines: true
      scaleGridLineColor: 'rgba(0,0,0,.05)'
      scaleGridLineWidth: 1
      barShowStroke: true
      barStrokeWidth: 1
      barValueSpacing: 5
      barDatasetSpacing: 1
      responsive: true

    # Data for Bar chart
    singleBarData =
      labels: []
      datasets: [ {
        label: ''
        fillColor: 'rgba(77,216,136, .5)'
        strokeColor: 'rgba(98,203,49,0.8)'
        highlightFill: 'rgba(77,216,136, 1)'
        highlightStroke: 'rgba(98,203,49,1)'
        data: []
      } ]

    months = [
      "January"
      "February"
      "March"
      "April"
      "May"
      "June"
      "July"
      "August"
      "September"
      "October"
      "November"
      "December"
    ]

    data_points = {}

    # First, fill data with 6 months of empty values
    earliest_date = null
    for i in [5,4,3,2,1,0]
      date = new Date()
      date.setMonth(date.getMonth() - i)
      month = months[date.getMonth()]
      data_points[month] = 0
      earliest_date = date unless earliest_date

    # Then, iterate over the sales objects and determine if they fall within the 6 month container, if so, use them
    for sale in sales
      sale_date = new Date(sale['date'])
      if sale_date.getMonth() >= earliest_date.getMonth()
        month = sale_date.getMonth()
        month = months[month]
        data_points[month] = 0 unless data_points[month]
        data_points[month] += 1

    for k,v of data_points
      singleBarData.labels.push k
      singleBarData.datasets[0].data.push v

    ctx = document.getElementById("salesBarChart").getContext('2d')
    new Chart(ctx).Bar singleBarData, singleBarOptions

  getItemData: =>
    user_name_label = $("#user_name")
    user_name_label.text 'Getting User Info...'
    api_token = mct
    if @user
      dashboardDataJS.parseUserDataAndUpdateUI(@user)
    else if api_token
      $.ajax
        type: "GET"
        url: merchapi.host() + "/items?token=#{api_token}&per_page=100"
        headers:
          'Accept': 'application/json'
        async: true
        success: (items) ->
          $("#item-data").load("/items/info", {"items":items}, (responseText, textStatus, xhr) ->
          )
        error: (data) ->
          user_name_label.text 'Error Loading User Info'
    else
      user_name_label.text 'Error Loading User Info'

  stopEvent: (e) ->
    e.preventDefault()
    e.stopPropagation()

  round: (number, precision) =>
    precision = Math.abs(parseInt(precision)) || 0
    multiplier = Math.pow(10, precision)
    Math.round(number * multiplier) / multiplier

@dashboardDataJS = new DashboardDataJS("")
@dashboardDataJS.getSalesData()
@dashboardDataJS.getItemData()