if Rails.env == 'production'
	Rails.configuration.stripe = {
		:publishable_key => ENV['STRIPE_PRO_PUB_KEY'],
		:secret_key => ENV['STRIPE_PRO_SEC_KEY']
	}
else
	Rails.configuration.stripe = {
		:publishable_key => ENV['STRIPE_DEV_PUB_KEY'],
		:secret_key => ENV['STRIPE_DEV_SEC_KEY']
	}
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]