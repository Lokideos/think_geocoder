# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'rake', '~> 13.0.0'
gem 'puma', '~> 4.3.12'
gem 'roda', '~> 3.33.0'

gem 'i18n', '~> 1.8.2'
gem 'config', '~> 2.2.1'

gem 'pg', '~> 1.2.3'
gem 'sequel', '~> 5.32.0'

gem 'dry-initializer', '~> 3.0.3'
gem 'dry-validation', '~> 1.5.0'

gem 'fast_jsonapi', '~> 1.5'

gem 'pry', '~> 0.13.0'

group :development, :test do
  gem 'pry-byebug', '~> 3.9.0'

  gem 'rspec', '~> 3.9.0'
  gem 'rack-test', '~> 1.1.0'
  gem 'database_cleaner-sequel', '~> 1.8.0'

  gem 'rack-unreloader', '~> 1.7.0'
end