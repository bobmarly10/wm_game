source 'https://rubygems.org'
ruby '1.9.3'
gem 'rails', '4.1.1'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'high_voltage'
gem "therubyracer"
gem 'mysql2'
gem 'airbrake'

gem 'simple_enum'

gem 'resque'
gem 'resque-scheduler'

gem 'pusher'

# omniauth
#gem 'mogli', github: 'mmangino/mogli'
#gem 'facebooker2', github: 'mmangino/facebooker2'
gem 'rack-facebook-signed-request', github: 'cmer/rack-facebook-signed-request'
gem 'omniauth'
gem 'omniauth-facebook'

# views
gem 'bootstrap-sass'
gem 'compass-rails'
gem 'haml-rails'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'simple_form', github: 'plataformatec/simple_form', tag: 'v3.1.0.rc1'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails', '>= 3.0.0.beta2'
  gem 'thin'
  #gem 'unicorn'
  #gem 'unicorn-rails'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'selenium-webdriver'
end
