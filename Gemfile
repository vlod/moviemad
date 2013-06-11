source 'https://rubygems.org'

gem 'rails', '~> 3.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
# gem 'curb'
gem 'ansi'
gem 'bootstrap-sass'
gem 'kaminari'
gem 'curb'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
gem 'jbuilder'

group :assets do
  gem 'hogan_assets' # https://github.com/leshill/hogan_assets
end

group :test do
  gem 'database_cleaner' # required by capybara
  gem 'factory_girl_rails'
  gem 'watchr' # run tests automatically http://goo.gl/Iwo1b tutorial http://goo.gl/coEpa
end

group :test, :development do
  gem 'rspec-rails'
  gem 'awesome_print'
end

group :development do
  # gem 'rvm-capistrano'
  gem 'debugger'
  gem 'quiet_assets'
  # gem 'thin'
  gem 'better_errors' # https://github.com/charliesome/better_errors
  gem 'binding_of_caller' # https://github.com/banister/binding_of_caller
end
