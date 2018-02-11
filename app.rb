ENV["RACK_ENV"] ||= "development"
Bundler.require(:default, ENV["RACK_ENV"])

require "rollbar/middleware/sinatra"

class App < Sinatra::Base
  use Rollbar::Middleware::Sinatra

  get "/" do
    "It works"
  end

  post "/webhook" do
    message = <<~MSG
      Build finished by @#{params[:push_data][:pusher]} :beer:
      #{params[:repository][:repo_name]}:#{params[:push_data][:tag]}
      #{params[:repository][:repo_url]}
    MSG

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
