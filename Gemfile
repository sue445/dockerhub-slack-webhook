# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

ruby "3.0.0"

gem "activesupport", require: "active_support/all"
gem "puma"
gem "rollbar"
gem "sinatra", ">= 2.1.0"
gem "sinatra-contrib", ">= 2.1.0"
gem "slack-notifier", github: "fusic/slack-notifier", branch: "resolve_warning_ruby27" # c.f. https://github.com/stevenosloan/slack-notifier/pull/119

group :development do
  gem "foreman", require: false
  gem "onkcop", ">= 1.0.0.0", require: false
  gem "rake", require: false
  gem "rubocop_auto_corrector", require: false
  gem "rubocop-performance", require: false
end

group :test do
  gem "coveralls", require: false
  gem "rack-test"
  gem "rspec"
  gem "simplecov", require: false
end
