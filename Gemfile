source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use postgresql as the database for Active Record
gem 'pg'
gem 'validates_existence'
# Use Carrierwave for uploads
gem 'carrierwave'
gem 'mini_magick'
# Use Devise for authentication
gem 'devise'
# Use declarative_authorization for authentication
gem 'declarative_authorization', github: 'stffn/declarative_authorization'
# Use Formtastic + Cocoon to handle dynamic forms
gem 'formtastic'
gem 'cocoon'
gem 'formtastic-bootstrap', github: '0xCCD/formtastic-bootstrap'
# Use Twitter Bootstrap for visual appeal
gem 'twitter-bootstrap-rails'
# Use kaminari for pagination
gem 'kaminari'
gem 'kaminari-bootstrap'
# Use HAML as template language
gem 'haml-rails'
# Use Less for stylesheets
gem 'less-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

group :development, :test do
  gem 'spring'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'shoulda-matchers', :require => false
  gem 'factory_girl_rails'
  gem 'simplecov'
end

group :development do
  gem 'quiet_assets'
end

group :production do
  gem 'fog'
  gem 'rails_12factor'
  gem 'unicorn'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]