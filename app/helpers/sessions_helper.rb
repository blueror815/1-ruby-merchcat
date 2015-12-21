module SessionsHelper

  def sign_in(token)
    secret_token = token + secret_key
    cookies.permanent[:remember_token] = secret_token
  end

  def set_uber(uber_admin)
    cookies.permanent[:uber_admin] = uber_admin
  end

  def sign_out
    cookies.delete(:remember_token)
    cookies.delete(:uber_admin)
  end

  def signed_in?
    !current_token.nil?
  end

  def current_token
    remember_token = cookies[:remember_token]
    remember_token.sub secret_key, '' if remember_token
  end

  def secret_key
    ENV['SESSION_SECRET']
  end

end