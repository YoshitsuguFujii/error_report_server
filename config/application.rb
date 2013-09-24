require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module ErrorReportServer
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = :ja

    # devise
    config.assets.initialize_on_precompile = false

    # generatorの設定
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
      #g.test_framework  :rspec, :fixture => true
      #g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end

    # load original validator(オリジナルのバリデーターがある場合のみ)
    #config.autoload_paths += %W(#{config.root}/lib/validators)

    # lib
    config.autoload_paths += %W(#{config.root}/lib/util)
    config.autoload_paths += %W(#{config.root}/lib/helpers)

    # devise
    config.to_prepare do
      Devise::SessionsController.layout "simple"
      #Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "devise" }
      #Devise::ConfirmationsController.layout "devise"
      #Devise::UnlocksController.layout "devise"
      #Devise::PasswordsController.layout "devise"
    end

  end
end
