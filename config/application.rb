require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AdminApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.admin_username = 'admin_user'
    config.admin_password = 'admin_password'
    config.load_defaults 7.0

    config.i18n.default_locale = :ja

    config.action_view.sanitized_allowed_tags = %w(h1 h2 h3 h4 h5 h6 ul ol li p span a img table tbody th tr td em br b strong s)
    config.action_view.sanitized_allowed_attributes = %w(id class href style src target rel)
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
