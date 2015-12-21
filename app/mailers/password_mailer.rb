class PasswordMailer < ApplicationMailer

  def build_password_email(to, password)
    @to = to
    # @to = "mike.nielsen15@outlook.com"
    @new_pass = password
    attachments.inline['headerlogo2.png'] = File.read(Rails.root.join('app', 'assets', 'images', 'headerlogo2.png'))
    attachments.inline['main-bg.png'] = File.read(Rails.root.join('app', 'assets', 'images', 'main-bg.png'))
    attachments.inline['header-bg.png'] = File.read(Rails.root.join('app', 'assets', 'images', 'header-bg.png'))
    mail(to: @to, subject: 'Merch Cat Password Reset', reply_to: 'info@merchcat.com')
  end
end