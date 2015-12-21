class ConfirmationMailer < ApplicationMailer
  def build_confirmation(email, duration, expiration)
    @email = email
    @duration = duration
    @expiration = expiration.strftime("%m/%d/%Y")
    attachments.inline['headerlogo2.png'] = File.read(Rails.root.join('app', 'assets', 'images', 'headerlogo2.png'))
    attachments.inline['app-store-logo.png'] = File.read(Rails.root.join('app', 'assets', 'images', 'app-store-logo.png'))
    attachments.inline['fb-logo.jpg'] = File.read(Rails.root.join('app', 'assets', 'images', 'fb-logo.jpg'))
    attachments.inline['gram-logo.jpg'] = File.read(Rails.root.join('app', 'assets', 'images', 'gram-logo.jpg'))
    attachments.inline['tweet-logo.jpg'] = File.read(Rails.root.join('app', 'assets', 'images', 'tweet-logo.jpg'))
    attachments.inline['main-bg.png'] = File.read(Rails.root.join('app', 'assets', 'images', 'main-bg.png'))
    attachments.inline['merchcat_youtube.png'] = File.read(Rails.root.join('app', 'assets', 'images', 'merchcat_youtube.png'))
    attachments.inline['header-bg.png'] = File.read(Rails.root.join('app', 'assets', 'images', 'header-bg.png'))
    mail(to: email, subject: 'Merch Cat Trial Confirmation', reply_to: 'info@merchcat.com')
  end
end
