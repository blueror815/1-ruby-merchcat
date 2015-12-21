class SettlementMailer < ApplicationMailer

  layout false

  def build_settlement_email(to, sales, show, items)
    @sales = sales
    @show = show
    @items = items
    mail(to: to, subject: 'Merch Cat Show Settlement', reply_to: 'info@merchcat.com')
  end
end
