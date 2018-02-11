# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby "2.5.0"

gem "puma"
gem "puma-heroku"
gem "sinatra"

group :development do
  gem "foreman", require: false
  gem "onkcop", require: false
end

group :test do
  gem "rack-test"
  gem "rspec"
end
