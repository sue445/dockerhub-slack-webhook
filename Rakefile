require "rollbar/rake_tasks"

task :environment do # rubocop:disable Rake/Desc
  Rollbar.configure do |config|
    config.access_token = ENV["ROLLBAR_ACCESS_TOKEN"]
  end
end
