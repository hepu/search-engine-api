# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'bootsnap', '>= 1.4.4', require: false
gem "foreman", "~> 0.87.2", require: false
gem 'httparty', "~> 0.18.1"
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails", "~> 2.7"
  gem "rspec-rails", "~> 4.0"
  gem "rubocop-rails", "~> 2.9.1", require: false
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring', '~> 2.1.1'
end
