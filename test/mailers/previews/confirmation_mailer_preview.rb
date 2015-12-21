# Preview all emails at http://localhost:3000/rails/mailers/confirmation_mailer
class ConfirmationMailerPreview < ActionMailer::Preview
  def build_confirmation_sample
    ConfirmationMailer.build_confirmation 'test@test.com'
  end
end
