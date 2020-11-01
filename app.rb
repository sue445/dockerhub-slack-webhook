ENV["RACK_ENV"] ||= "development"
Bundler.require(:default, ENV["RACK_ENV"])

require "rollbar/middleware/sinatra"
require "sinatra/custom_logger"

class App < Sinatra::Base
  use Rollbar::Middleware::Sinatra

  helpers Sinatra::CustomLogger

  configure do
    debug_logging = ENV["DEBUG_LOGGING"] == "true"
    logger = Logger.new($stdout)
    logger.level = debug_logging ? Logger::DEBUG : Logger::INFO

    set :logger, logger
  end

  get "/" do
    "It works"
  end

  post "/webhook" do
    payload = JSON.parse(request.body.read)

    logger.debug { "payload=#{payload}, params=#{params}" }

    message = <<~MSG
      Build finished by @#{payload["push_data"]["pusher"]} :beer:
      #{payload["repository"]["repo_name"]}:#{payload["push_data"]["tag"]}
      #{payload["repository"]["repo_url"]}
    MSG

    logger.debug { "message=#{message}" }

    channel =
      if params[:channel].blank?
        ENV["SLACK_CHANNEL"]
      else
        "#" + params[:channel]
      end

    App.post_slack(
      webhook_url: ENV["SLACK_WEBHOOK_URL"],
      channel:     channel,
      username:    ENV["SLACK_USERNAME"],
      message:     message,
    )

    ""
  end

  def self.post_slack(webhook_url:, channel:, username:, message:)
    notifier = Slack::Notifier.new(webhook_url)

    options = {
      icon_emoji:  ":whale:",
      attachments: [
        {
          fallback: message,
          text:     message,
          color:    "good",
        },
      ],
    }
    options[:username] = username if username
    options[:channel] = channel if channel

    notifier.ping(nil, options)
  end
end
