source 'https://rubygems.org'

ruby "2.0.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

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

gem 'mysql2'
gem 'devise'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-livereload'

  gem 'erb2haml'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'pry-rails'
  gem "pry-byebug"

  gem 'hirb'
  gem 'hirb-unicode'
  gem 'awesome_print'

  gem 'spring'
  gem 'colorize_unpermitted_parameters'
end

group :production do
  gem 'rails_12factor'
  gem 'pg'
end


gem 'haml-rails'
gem 'compass_twitter_bootstrap'
gem 'compass-rails', github: "milgner/compass-rails", branch: "rails4"
gem 'compass-colors'
gem 'kaminari'
gem 'simple_form'
gem 'country_select'


gem 'bootstrap-sass'
gem 'bootswatch-rails'
gem 'twitter-bootstrap-rails'

gem 'activerecord-import'

gem 'seed-fu', github: 'mbleigh/seed-fu'

group :assets do
  gem 'therubyracer', :platforms => :ruby
end

gem 'mongoid', '~> 4', github: 'mongoid/mongoid'
gem 'bson_ext'
