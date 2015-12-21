# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def build_email_sample
    ContactMailer.build_email 'Jeremy Fox', 'test@test.com', 'I love you!'
  end
end
