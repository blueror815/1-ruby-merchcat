class MembershipController < ApplicationController
  	def upgrade_membership
  	  	
        stripe_token = params[:stripe_token]
  	  	email = params[:email]
  	  	plan = "MCATM1"
    		# Stripe.api_key = "sk_test_4tyh70Tont98bmMWSmMfJhD5"
    		customer = Stripe::Customer.create(:source => stripe_token, :email => email, :plan => plan)

  		  render :json => customer
      
  	end

    def retrieve_customer

        stripe_customer_id = params[:stripe_customer_id]
        begin
          customer = Stripe::Customer.retrieve(stripe_customer_id)
          render :json => customer
        rescue Errno::ETIMEDOUT => e
          log.error e
        end
    end

end
