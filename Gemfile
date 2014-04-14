source 'https://rubygems.org'
ruby "1.9.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use unicorn as the app server
gem 'unicorn'

# HAML is my templater
gem 'haml'

# Postgres is our DB.
gem 'pg'

# stuff for Foursquare
gem 'addressable'
gem 'rest-client'
gem 'oauth2'
gem 'foursquare2'

# pagination
gem 'kaminari'

# heroku nonsense
group :production do
  gem 'rails_12factor'
end

# stuff for queueing: Sidekiq, basically
gem 'sidekiq'
gem 'slim' # for the web UI
# if you require 'sinatra' you get the DSL extended to Object
gem 'sinatra', :require => nil 
