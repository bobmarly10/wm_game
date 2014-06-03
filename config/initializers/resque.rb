require 'resque'
require 'yaml'

redis = YAML::load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env]
Resque.redis = redis
Resque.redis.namespace = "resque:wm_game:#{Rails.env}"

require 'resque-scheduler'
require 'resque/scheduler/server'
Resque.schedule = YAML.load_file(File.join(Rails.root, 'config/resque_schedule.yml')) # load the schedule

require 'resque/failure/multiple'
require 'resque/failure/redis'
Resque::Failure::Multiple.classes = []
Resque::Failure::Multiple.classes << Resque::Failure::Redis

if ["demo", "staging", "production"].include?(Rails.env)
  require 'resque/failure/airbrake'
  Resque::Failure::Airbrake.configure do |config|
    config.api_key = Rails.application.secrets.airbrake
    config.secure = true
  end
  Resque::Failure::Multiple.classes << Resque::Failure::Airbrake
end

Resque::Failure.backend = Resque::Failure::Multiple

# Disconnect workers before forking
Resque.before_fork do
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

# After forks
# reconnect clients and hook up the DB
Resque.after_fork do
  Resque.redis.client.reconnect
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection(
      Rails.application.config.database_configuration[Rails.env]
    )
end
