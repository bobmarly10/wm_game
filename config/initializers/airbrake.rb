Airbrake.configure do |config|
  config.api_key = Rails.application.secrets.airbrake
end
