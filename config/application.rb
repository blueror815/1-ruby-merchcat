require File.expand_path('../boot', __FILE__)

# require 'rails/all'

# for exporting CSV file
require 'csv'

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Myapp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Admin assets
    config.assets.precompile += [ 'appviews.css', 'cssanimations.css', 'dashboards.css', 'forms.css', 'gallery.css', 'graphs.css', 'mailbox.css', 'miscellaneous.css', 'pages.css', 'tables.css', 'uielements.css', 'widgets.css' ]
    config.assets.precompile += [ 'appviews.js', 'cssanimations.js', 'dashboards.js', 'forms.js', 'gallery.js', 'graphs.js', 'mailbox.js', 'miscellaneous.js', 'pages.js', 'tables.js', 'uielements.js', 'widgets.js', ]

    # Home page assets
    config.assets.precompile += [ 'home/partials/_alerts.scss', 'home/partials/_buttons.scss', 'home/bootstrap.css', 'home/ionicons.min.css', 'home/style.scss' ]
    config.assets.precompile += [ 'home/bootstrap.js', 'home/ie10-viewport-bug-workaround.js', 'home/jquery.min.js', 'main.js.coffee', 'retina-1.1.0.js' ]

  end
end