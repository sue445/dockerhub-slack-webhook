ENV["RACK_ENV"] ||= "development"
Bundler.require(:default, ENV["RACK_ENV"])

require "rollbar/middleware/sinatra"
require "sinatra/custom_logger"

class App < Sinatra::Base
  use Rollbar::Middleware::Sinatra

  helpers Sinatra::CustomLogger

  configure do
    debug_logging = ENV["DEBUG_LOGGING"] == "true"
    logger = Logger.new(STDOUT)
    logger.level = debug_logging ? Logger::DEBUG : Logger::INFO

    set :logger, logger
  end

  get "/" do
    "It works"
  end

  post "/webhook" do
    params = JSON.parse(request.body.read)

    logger.debug { "params=#{params}" }

    message = <<~MSG
      Build finished by @#{params["push_data"]["pusher"]} :beer:
      #{params["repository"]["repo_name"]}:#{params["push_data"]["tag"]}
      #{params["repository"]["repo_url"]}
    MSG

    logger.debug { "message=#{message}" }

    App.post_slack(
      webhook_url: ENV["SLACK_WEBHOOK_URL"],
      channel:     ENV["SLACK_CHANNEL"],
      username:    ENV["SLACK_USERNAME"],
      message:     message,
    )

    ""
  end

  def self.post_slack(webhook_url:, channel:, username:, message:)
    notifier = Slack::Notifier.new(webhook_url)

    options = {
      icon_emoji: ":whale:",
      attachments: [
        {
          fallback: message,
          text: message,
          color: "good",
        },
      ],
    }
    options[:username] = username if username
    options[:channel] = channel if channel

    notifier.ping(nil, options)
  end
end
