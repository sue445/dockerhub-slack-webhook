# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

ruby "2.6.2"

gem "activesupport", require: "active_support/all"
gem "puma"
gem "puma-heroku"
gem "rollbar"
gem "sinatra"
gem "sinatra-contrib"
gem "slack-notifier"

group :development do
  gem "foreman", require: false
  gem "onkcop", require: false
  gem "rake", require: false
end

group :test do
  gem "coveralls", require: false
  gem "rack-test"
  gem "rspec"
  gem "simplecov", require: false
end
