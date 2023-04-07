# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'hotwire-rails', '~> 0.1.3'
gem 'jbuilder', '~> 2.7'
gem 'paranoia', '~> 2.6'
gem 'puma', '~> 5.0'
gem 'pundit', '~> 2.3'
gem 'rails', '~> 6.1.7', '>= 6.1.7.3'
gem 'sass-rails', '>= 6'
gem 'sqlite3', '~> 1.4'
gem 'tailwindcss-rails', '~> 2.0'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'faker', '~> 3.1'
end

group :development do
  gem 'annotate', '~> 3.2'
  gem 'foreman', '~> 0.87.2'
  gem 'listen', '~> 3.3'
  gem 'rubocop-rails', '~> 2.19'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers', '~> 5.2'
end
