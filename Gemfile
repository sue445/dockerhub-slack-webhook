# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "activesupport", require: "active_support/all"
gem "puma"
gem "sentry-ruby"
gem "sinatra-contrib", ">= 2.2.0"
gem "slack-notifier", ">= 2.4.0"
gem "uri", ">= 0.12.2" # for CVE-2023-36617

group :development do
  gem "onkcop", ">= 1.0.0.0", require: false
  gem "rake", require: false
  gem "rubocop", require: false
  gem "rubocop_auto_corrector", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rake", require: false
end

group :test do
  gem "coveralls_reborn", require: false
  gem "rack-test"
  gem "rspec"
  gem "simplecov", require: false
end
