require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mark
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    def repository
      @repository ||= EventSourcery::Repository.new(
        event_source: EventSourcery::Postgres.config.event_store,
        event_sink: EventSourcery::Postgres.config.event_sink
      )
    end
  end
end

EventSourcery::Postgres.configure do |config|
  database = Sequel.connect(ENV['DATABASE_URL'], test: false)

  # NOTE: Often we choose to split our events and projections into separate
  # databases. For the purposes of this example we'll use one.
  config.event_store_database = database
  config.projections_database = database
end
