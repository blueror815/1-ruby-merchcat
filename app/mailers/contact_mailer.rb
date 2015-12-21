class ContactMailer < ApplicationMailer
  def build_email(name, email, message)
    @name = name
    @message = message
    mail(subject: 'Contact Form Submission', reply_to: email)
  end
end
